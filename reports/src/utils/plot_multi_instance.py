import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

import seaborn as sns

def processDiamondGas(df, num_instances):
    df['initial_gas_cost'] = df['diamond'] + df['instance'] + df['model']     # Compute the initial gas cost

    gas_costs = {}
    for model in df.index:
        gas_costs[model] = [df.loc[model, 'initial_gas_cost']]
        for i in range(1, num_instances):
            gas_costs[model].append(gas_costs[model][-1] + df.loc[model, 'instance'])

    # Create the new DataFrame
    df_new = pd.DataFrame(gas_costs).T
    df_new.columns = [f'Instance {i+1}' for i in range(num_instances)]
    df_new['modelName'] = df_new.index
    df_new.reset_index(drop=True, inplace=True)

    # Melt the DataFrame to long format
    df_melted = df_new.reset_index().melt(id_vars='modelName', var_name='Instance', value_name='Gas Cost')
    df_melted = df_melted[~df_melted['Instance'].str.contains('index')]
    df_melted['NumInstance'] = df_melted['Instance'].str.extract('(\d+)').astype(int)
    df_melted['Architecture'] = 'Diamond'

    return df_melted


def processMonolithicGas(df, num_instances):
    df_mono = df.loc[df['type'] == 'deployment']

    gas_costs_mono = {}
    for model in df_mono.modelName:
        gas_value = df_mono.loc[df_mono['modelName'] == model, 'gas'].values[0]
        gas_costs_mono[model] = [gas_value]

        for i in range(1, num_instances):
            gas_costs_mono[model].append(gas_costs_mono[model][-1] + gas_value)

    # Create the new DataFrame
    df_new_mono = pd.DataFrame(gas_costs_mono).T
    df_new_mono.columns = [f'Instance {i+1}' for i in range(num_instances)]
    df_new_mono['modelName'] = df_new_mono.index
    df_new_mono.reset_index(drop=True, inplace=True)

    # Melt the DataFrame to long format
    df_melted_mono = df_new_mono.reset_index().melt(id_vars='modelName', var_name='Instance', value_name='Gas Cost')
    df_melted_mono = df_melted_mono[~df_melted_mono['Instance'].str.contains('index')]
    df_melted_mono['NumInstance'] = df_melted_mono['Instance'].str.extract('(\d+)').astype(int)
    df_melted_mono['Architecture'] = 'Monolithic'

    return df_melted_mono

def plot_multi_instance_cost(df_diamond, df_gasMono, output_path):
    """
    Plot multi-instance cost.
    
    Parameters:
    - df_gasFactory: DataFrame containing gas costs for diamond methods.
    - df_diamondCore: DataFrame containing gas costs for diamond facets deployment cost.
    - df_gasMono: DataFrame containing gas costs for mono deployments.
    - model_names_mapping: List of model names mapping.
    - facet_names: list of facet names for aggregation
    - output_path: Path to save the plot image.
    - aggregate_choice: boolean to aggregate gas costs for diamond facets
    """

    numInstances = 10
    df_diamond = processDiamondGas(df_diamond, numInstances)
    df_mono = processMonolithicGas(df_gasMono, numInstances)
    df_merged = pd.concat([df_diamond, df_mono], ignore_index=True)
    df_merged = df_merged.rename(columns={'modelName': 'BPMN Model'})

    # Plot using seaborn
    plt.figure(figsize=(7, 5))
    sns.set_palette("colorblind")
    sns.lineplot(data=df_merged, x='NumInstance', y='Gas Cost', hue='BPMN Model', style='Architecture', marker='o')
    plt.xlabel('Number of BPMN Model Instances')
    plt.ylabel('Cumulative Gas Cost')
    plt.xscale('log')
    plt.yscale('log')

    xticks = plt.xticks()[0]
    plt.xticks(xticks, np.round(xticks).astype(int))
    plt.xlim(0.8, 12)
    plt.ylim(5e6, 2e8)
    # plt.title('Cumulative Gas Costs for Each Deployment', title_fontsize=tickFontSize+1, fontsize=tickFontSize)
    plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()
    plt.savefig(output_path)
