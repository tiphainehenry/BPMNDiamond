import pandas as pd
import json
import ast

def load_json(file_path):
    """Load JSON data from a file."""
    with open(file_path, 'r') as file:
        return json.load(file)

def load_json_2(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return json.load(file)  # Properly parse JSON data into a dictionary
    
def clean_model_name(name, mapping):
    for m in mapping:
        if (m["root_name"] in name):
            return m["modelName"]
    # print("no match for "+m["root_name"]+ " in "+name)
    return name

def process_monolithic_data(data_list, mapping):
    """Process monolithic gas results for deployment and methods."""
    dfs = []
    for i, dict_data in enumerate(data_list):

        # Extract methods gas (Invoke smart contract function execution)
        methods = dict_data["data"]["methods"]
        method_data = []
        for method_key, method_value in methods.items():
            if method_value["method"] == "Invoke" and len(method_value["intrinsicGas"]) > 0:
                method_data.append({
                    "type": "Invoke",
                    "modelName": clean_model_name(method_key, mapping),
                    "gas": method_value["executionGasAverage"]
                })
        df_methods = pd.DataFrame(method_data)

        # Extract deployments gas
        deployments = dict_data["data"]["deployments"]
        deployment_data = []        
        for depl in deployments:
            if len(depl["gasData"]) != 0 and depl["name"] != "DiamondLoupeFacet":
                deployment_data.append({
                    "type": "deployment",
                    "modelName": clean_model_name(depl["name"], mapping),
                    "gas": depl["executionGasAverage"]
                })
        df_deployments = pd.DataFrame(deployment_data)

        # Combine DataFrames
        dfs.append(pd.concat([df_methods, df_deployments], ignore_index=True)) 
    df_mono = pd.concat(dfs, ignore_index=True)
    df_mono['architecture'] = 'Monolithic'

    return df_mono

def aggregate_gas(gas):
    if isinstance(gas, list):
        return sum(gas) / len(gas)  # Taking the average of gas values
    return gas

def convert_gas(gas):
    if isinstance(gas, str):
        try:
            # Attempt to parse string lists
            return ast.literal_eval(gas)
        except (ValueError, SyntaxError):
            # If parsing fails, return float
            return float(gas)
    return gas


def process_diamond_core_deployment(deployments, facetNames):
    """Helper to process deployment costs for diamond core facets."""
    gasFactory = []

    for depl in deployments:
        if len(depl["gasData"]) != 0 and depl["name"] != "DiamondLoupeFacet":
            tpr = { 
                "diamondCoreElem": depl["name"], 
                "gas": depl["executionGasAverage"]
                }            
            if (depl["name"] in facetNames) and (depl["name"] != "DiamondCut"):
                gasFactory.append(tpr)   ### @Victor, why not take both diamond and diamondCut into account?

    df_core_diamond = pd.DataFrame(gasFactory)
    return df_core_diamond


def genMethodsDiamondDf(bpmn_df, mapping):
    filtered_result = bpmn_df[bpmn_df['method'].isin(['Invoke', 'diamondCut', 'addModel', 'newInstance'])]
    tpr = []
    for method in filtered_result.itertuples():
        dict = {
            "modelName": clean_model_name(method.modelName, mapping),
            "scenarioVariant": method.scenarioVariant, 
            "stage": method.method
        }
        if method.method == "Invoke" and len(method.intrinsicGas) > 0:
            dict ["gas"] = method.executionGasAverage 
            tpr.append(dict)
        elif method.method == "diamondCut" and len(method.intrinsicGas) > 0:
            dict ["gas"] = method.gasData 
            tpr.append(dict)
        elif method.method == "addModel" and len(method.intrinsicGas) > 0:
            dict ["gas"] = sum(method.gasData) 
            tpr.append(dict)

        elif method.method == "newInstance" and len(method.intrinsicGas) > 0:
            dict ["gas"] = method.gasData 
            tpr.append(dict)

    methodsDiamond_df = pd.DataFrame(tpr)    
    methodsDiamond_df['architecture'] = 'Diamond'

    return methodsDiamond_df

def process_diamond_data(data_list, file_names, facet_names, mapping):
    """Process diamond gas results for deployment and methods."""

    ## extract data from json dict
    dfs = []
    dfs_depl = []
    for i, dict_data in enumerate(data_list):
        deployments = dict_data["data"]["deployments"]
        methods = dict_data["data"]["methods"]

        ## Extract diamond core elem gas costs
        df_deploy = process_diamond_core_deployment(deployments,facet_names)
        dfs_depl.append(df_deploy)

        ## Extract model deployment and instantiation gas costs
        for key, value in methods.items():
            newdf = pd.DataFrame.from_dict([value])
            newdf['scenarioVariant'] = key
            newdf['modelName'] = file_names[i]
            dfs.append(newdf)

    ### prep core diamond df
    coreDiamond_df = []
    if dfs_depl:  
        coreDiamond_df = pd.concat(dfs_depl, ignore_index=True).groupby('diamondCoreElem', as_index=False).agg({'gas': 'mean'})

    ### prep methods diamond df
    bpmn_df = pd.concat(dfs, ignore_index=True)
    methodsDiamond_df = genMethodsDiamondDf(bpmn_df, mapping)


    return methodsDiamond_df, coreDiamond_df



def format_diamond(df_gasFactory, df_diamondCore, model_names_mapping, facet_names, bpmn_facet_names, aggregate_choice):

    # format diamond facets
    dfs_core = []
    for m in model_names_mapping :
        df_model = df_diamondCore.copy()
        df_model["modelName"] = m["modelName"]
        df_model["architecture"] = "Diamond"
        dfs_core.append(df_model) 
    merged_core = pd.concat(dfs_core, ignore_index=True)
    merged_core = merged_core.rename(columns={'diamondCoreElem': 'stage'})
    # format diamond methods
    df_gasFactory['gas'] = df_gasFactory['gas'].apply(aggregate_gas)
    # aggregate both and clean
    df = pd.concat([df_gasFactory, merged_core], ignore_index=True)
    df = df[df['stage'] != 'Invoke']

    # merge diamond facets if needed
    if aggregate_choice["aggregate_all_facets"]:    
        mask = df['stage'] == 'addModel'
        df.loc[mask, 'stage'] = 'model'

        mask = df['stage'] == 'newInstance'
        df.loc[mask, 'stage'] = 'instance'

        for facet in facet_names : 
            mask = df['stage'].str.lower() == facet.lower()
            df.loc[mask, 'stage'] = 'diamond'
    elif aggregate_choice["aggregate_only_diamondcore"]:    
        mask = df['stage'] == 'addModel'
        df.loc[mask, 'stage'] = 'model'

        mask = df['stage'] == 'newInstance'
        df.loc[mask, 'stage'] = 'instance'

        for facet in facet_names : 
            if (facet not in bpmn_facet_names):
                mask = df['stage'].str.lower() == facet.lower()
                df.loc[mask, 'stage'] = 'diamond'
            # else:
            #     mask = df['stage'].str.lower() == facet.lower()
            #     initName = df.loc[mask, 'stage'].str.replace("BPMN",'').str.replace("Facet",'').str.lower().str.replace("modelfactory",'factory')
            #     df.loc[mask, 'stage'] = 'BPMN '+ initName+" facet"

    df_diamond_deploy = df.pivot_table(index='modelName', columns='stage', values='gas', aggfunc='sum', fill_value=0)    

    return df_diamond_deploy

def process_multi_model(data_list, mapping, output_path,max_iterations):
    """Process multimodel gas results and track file names."""
    dfs = []
    for item in data_list:
        file_name = item['file_name'].replace(r'../data/Json/gasReport_multimodel_',"").replace(".json", '')
        dict_data = item['data']
        
        # Ensure dict_data is a dictionary
        if not isinstance(dict_data, dict):
            print(f"Error: dict_data for file {file_name} is not a dictionary. Type found: {type(dict_data)}")
            continue  # Skip this iteration if dict_data is not a dictionary
        
        # Extract methods gas (Invoke smart contract function execution)
        methods = dict_data["data"]["methods"]
        method_data = []
        for method_key, method_value in methods.items():
            if method_value["method"] == "addModel" and len(method_value["intrinsicGas"]) > 0:
                method_data.append({
                    "file_name": clean_model_name(file_name, mapping),  # Track the file name
                    "type": method_value["method"],
                    "modelName": clean_model_name(method_key, mapping),
                    "gas": method_value["executionGasAverage"]
                })
        df_methods = pd.DataFrame(method_data)

        # Extract deployments gas
        deployments = dict_data["data"]["deployments"]
        deployment_data = []        
        for depl in deployments:
            if len(depl["gasData"]) != 0 and depl["name"] != "DiamondLoupeFacet":
                deployment_data.append({
                    "file_name": clean_model_name(file_name, mapping),  # Track the file name
                    "type": "deployment",
                    "modelName": clean_model_name(depl["name"], mapping),
                    "gas": depl["executionGasAverage"]
                })
        df_deployments = pd.DataFrame(deployment_data)

        # Combine DataFrames for this specific file's data
        dfs.append(pd.concat([df_methods, df_deployments], ignore_index=True)) 

    # Combine all DataFrames
    df_multi = pd.concat(dfs, ignore_index=True)

    df_expanded = expand_add_model_iterations(df_multi, max_iterations)
    # Save to Excel
    df_multi.to_excel(output_path, index=False)
    df_expanded.to_excel(output_path.replace(".xlsx","")+"expanded.xlsx", index=False)


    return df_expanded


def expand_add_model_iterations(df, iterations=10):
    # Filter the rows for 'addModel'
    add_model_df = df[df['type'] == 'addModel']
    
    # Repeat each 'addModel' row for the specified number of iterations
    add_model_df = pd.concat([add_model_df] * iterations, ignore_index=True)
    
    # Assign iteration numbers to each repeated row for plotting
    add_model_df['iteration'] = add_model_df.groupby('file_name').cumcount() + 1

    # Combine the expanded DataFrame back with the original filtered DataFrame (for deployment)
    df_deployment = df[df['type'] == 'deployment']
    df_expanded = pd.concat([df_deployment, add_model_df], ignore_index=True)
    # df_expanded['file_name'] = df_expanded['file_name'].str.replace(r'\.\./data/Json/gasReport_multimodel_(.*)\.json', r'\1', regex=True)

    deployment_sum = df_expanded[df_expanded['type'] == 'deployment'].groupby('file_name', as_index=False).agg({'gas': 'sum'})
    deployment_sum['type'] = 'deployment'
    deployment_sum['modelName'] = 'Diamond Core'
    deployment_sum['iteration'] = 1

    # Filter out the original deployment rows and concatenate the summed rows
    df_filtered = df_expanded[df_expanded['type'] != 'deployment']
    df_combined = pd.concat([df_filtered, deployment_sum], ignore_index=True)





    return df_combined