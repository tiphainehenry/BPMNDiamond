import json
import pandas as pd
from utils.data_processing import load_json, process_diamond_data, process_monolithic_data, format_diamond, process_multi_model
from utils.plot_deployment import plot_deployment_cost
from utils.plot_invoke import plot_invoke_cost
from utils.plot_multi_instance import plot_multi_instance_cost
from utils.plot_multi_model import plot_multi_process_cost
from utils.describeXML import process_bpmn_files


def load_config():
    """Load configuration from a JSON file."""
    with open('reports_config.json', 'r') as file:
        return json.load(file)

def main():
    # Load configuration
    config = load_config()

    # Generate mono_files and df_files 
    mono_template = config["gas_report_root"]+"{}Mono.json"
    diamondFactory_template = config["gas_report_root"]+"{}DF.json"
    multiModel_template = config["gas_report_root"]+"multimodel_{}.json"

    mono_files = [mono_template.format(mapping['root_name']) for mapping in config['model_names_mapping']]
    diamondFactory_files = [diamondFactory_template.format(mapping['root_name']) for mapping in config['model_names_mapping']]
    multModel_files = [multiModel_template.format(mapping['root_name']) for mapping in config['model_names_mapping']]

    # Monolithic DATA PROCESSING
    mono_data = [load_json(file) for file in mono_files]
    df_gasMono = process_monolithic_data(mono_data, config['model_names_mapping'])

    # DIAMOND DATA PROCESSING
    modelNames = [mapping['modelName'] for mapping in config['model_names_mapping']]
    factory_data = [load_json(file) for file in diamondFactory_files]
    
    df_diamondMethods, df_diamondCore = process_diamond_data(factory_data, modelNames, config['facet_names'], config['model_names_mapping'])

    df_diamondMethods_formatted = format_diamond(
        df_diamondMethods, 
        df_diamondCore, 
        config['model_names_mapping'], 
        config['facet_names'],
        config['bpmn_facet_names'],
        config['aggregate_facets_choice']
        )
    df_gasMono_cp = df_gasMono.copy()
    df_mono_formatted = df_gasMono_cp[df_gasMono_cp['type'] == 'deployment']

    # Multi model PROCESSING
    multiModel_data = [{'file_name': file, 'data': load_json(file)} for file in multModel_files]
    df_gasMultiModel = process_multi_model(multiModel_data, 
                                           config['model_names_mapping'],
                                           config['data_output_paths']['gas_multi'], 
                                           config["iteration_multi_models"])


    # # # Plot graphs
    plot_deployment_cost(
        df_diamondMethods_formatted,
        df_mono_formatted, 
        config['aggregate_facets_choice'],
        len(config['model_names_mapping']),
        config['plot_output_paths']['deploy_cost']
    )
    
    plot_invoke_cost(
        df_diamondMethods, 
        df_gasMono, 
        config['plot_output_paths']['invoke_cost']
    )
    
    plot_multi_instance_cost(
        df_diamondMethods_formatted,
        df_gasMono,
        config['plot_output_paths']['multi_instance_cost']
    )
    
    plot_multi_process_cost(
        # df_diamondMethods,
        # df_diamondCore, 
        # df_gasMono, 
        df_gasMultiModel,
        df_mono_formatted,
        config['model_names_mapping'], 
        config['colors'], 
        config['data_output_paths']['multi_process_cost2'],
        config['plot_output_paths']['multi_process_cost'],
        config["iteration_multi_models"]
    )

    # df_struct_bpmn = process_bpmn_files(config['XML_files'])
    # print(df_struct_bpmn)

    # if config['saveDataframesToExcel'] == 1:    
    #     df_diamondCore.to_excel(config['data_output_paths']['gas_diamond_facets'], index=False)
    #     df_diamondMethods.to_excel(config['data_output_paths']['gas_diamond_methods'], index=False)
    #     df_gasMono.to_excel(config['data_output_paths']['gas_mono'], index=False)
    #     # df_struct_bpmn.to_excel(config['data_output_paths']['bpmn_element_counts'], index=False)
    


if __name__ == "__main__":
    main()
