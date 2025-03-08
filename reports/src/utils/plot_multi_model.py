import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import ast
import numpy as np


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
    # # Plot Mono multi-process data
    # for idx, row in df_gasMono.iterrows():
    #     tabTpr = [row[1] * i for i in range(30)]
    #     plt.plot(abscisse, tabTpr, label=model_names[idx], color=colors[idx])

    return df_melted_mono


def plot_multi_process_cost(df, df_mono, model_names_mapping, colors, output_path, output_path_plot, max_iteration):
    # Assuming df is already loaded as provided
    # Separate deployment and addModel entries


    df_deployment = df[df['type'] == 'deployment']
    df_add_model = df[df['type'] == 'addModel']

    # Map deployment gas costs to each file_name
    deployment_gas_map = df_deployment.set_index('file_name')['gas'].to_dict()

    # Compute cumulative gas for diamond approach
    cumulative_gas_list = []
    for file_name, group in df_add_model.groupby('file_name'):
        cumulative_gas = deployment_gas_map.get(file_name, 0)  # Start with deployment gas
        for _, row in group.iterrows():
            cumulative_gas += row['gas']
            cumulative_gas_list.append({
                'BPMN Model': file_name,
                'iteration': row['iteration'],
                'gas': row['gas'],
                'cumulative_gas': cumulative_gas,
                'Approach': "Diamond"
            })

    # Create DataFrame for diamond cumulative gas
    df_cumulative = pd.DataFrame(cumulative_gas_list)

    # Compute cumulative gas for monolithic approach
    monolithic_cumulative_list = []
    
    for model_name, gas_cost in df_mono[['modelName', 'gas']].values:
        cumulative_gas = 0
        for iteration in range(1, max_iteration + 1):
            cumulative_gas += gas_cost
            monolithic_cumulative_list.append({
                'BPMN Model': model_name,
                'iteration': iteration,
                'cumulative_gas': cumulative_gas,
                'Approach': 'Monolithic'
            })

    # Create DataFrame for monolithic cumulative gas
    df_monolithic_cumulative = pd.DataFrame(monolithic_cumulative_list)

    # Combine both DataFrames
    df_combined = pd.concat([df_cumulative, df_monolithic_cumulative], ignore_index=True)

    # Optionally export the combined DataFrame to Excel
    output_path = "cumulative_gas_comparison.xlsx"
    df_combined.to_excel(output_path, index=False)

    # Plot cumulative gas cost comparison
    plt.figure(figsize=(7, 5))
    sns.set_palette("colorblind")
    sns.lineplot(data=df_combined, x='iteration', y='cumulative_gas', hue='BPMN Model', style='Approach', markers=True)
    plt.title('Cumulative Gas Cost Comparison: Diamond vs. Monolithic Methods')
    plt.xlabel('Number of BPMN Models Registered')
    plt.ylabel('Cumulative Gas Cost')
    # plt.xscale('log')
    # plt.yscale('log')
    
    xticks = plt.xticks()[0]
    plt.xticks(xticks, np.round(xticks).astype(int))

    xbound = max_iteration+0.2
    plt.xlim(0.8, xbound)
    plt.ylim(5e6, 3e8)

    plt.legend(loc='upper left', bbox_to_anchor=(1, 1))
    plt.xticks(rotation=45, ha='right')

    plt.tight_layout()
    plt.savefig(output_path_plot)





    # data_complexity = {
    # "BPMN Model": [
    #     "B", "H", "E", "F", 
    #     "C", "A",  
    #     "G", "D", 
    #     "J", "I"
    # ],
    # "Normalized Complexity": [
    #     0.595505618, 0.988764045, 0.629213483, 0.797752809, 
    #     0.595505618, 0.112359551,  
    #     0.359550562, 0.359550562, 
    #     1.0, 0.865168539
    # ]
    # }

    # df_complexity = pd.DataFrame(data_complexity)

    # # Ensure df_combined contains the 'file_name' column as in df_complexity
    # # Clean up the 'file_name' column to match

    # # Merge the cumulative gas costs with the normalized complexity DataFrame
    # merged_df = pd.merge(df_combined, df_complexity, how='left', left_on='BPMN Model', right_on='BPMN Model')

    # # Plot cumulative gas cost against normalized complexity
    # plt.figure(figsize=(16, 10))
    # sns.lineplot(data=merged_df, x='Normalized Complexity', y='cumulative_gas', markers=True)
    # plt.title('Cumulative Gas Cost Comparison: Diamond vs. Monolithic Methods by Normalized Complexity')
    # plt.xlabel('Normalized Complexity')
    # plt.ylabel('Cumulative Gas Cost')
    # plt.legend(title='Approach')
    # plt.grid()
    # plt.tight_layout()
    # plt.show()

