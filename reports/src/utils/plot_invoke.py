import matplotlib.pyplot as plt
import pandas as pd

import seaborn as sns
from utils.data_processing import (convert_gas, aggregate_gas)

def plot_invoke_cost(df_gasFactory, df_gasMono, output_path):
    """
    Plot invoke cost.
    
    Parameters:
    - df_gasFactory: DataFrame containing gas costs for diamond deployments.
    - df_gasMono: DataFrame containing gas costs for mono deployments.
    - output_path: Path to save the plot image.
    """

    # concatenate and process dataframes
    df_gasFactory['Architecture'] = 'Diamond'
    df_gasFactory['gas'] = df_gasFactory['gas'].apply(convert_gas).apply(aggregate_gas)

    df_gasMono['Architecture'] = 'Monolithic'
    df_gasMono['gas'] = df_gasMono['gas'].apply(convert_gas).apply(aggregate_gas)
    df_gasMono = df_gasMono.rename(columns={'type': 'stage'})

    combined_df = pd.concat([df_gasFactory, df_gasMono])

    # filter dataframe to fetch only invoke gas info
    invoke_df = combined_df[combined_df['stage'] == 'Invoke']
    avg_gas_per_scenario = invoke_df.groupby(['modelName', 'Architecture'])['gas'].mean().reset_index()

    # plot 
    paddingWidth = 1    # sets legend to the right of the figure

    plt.figure(figsize=(5, 3))
    sns.set_palette("colorblind")
    sns.barplot(x='modelName', y='gas', hue='Architecture', data=avg_gas_per_scenario, palette='viridis', width=0.6)
    plt.xlabel('')  
    plt.ylabel('Average Gas Cost')     
    plt.xticks(rotation=45, ha='right') 
    plt.legend(
        title='Architecture', 
        bbox_to_anchor=(paddingWidth, 1)
        )
    plt.xticks(rotation=45, ha='right')
    # plt.title('Average Invoke Gas Costs per Scenario (Diamond vs. Monolithic)')
    plt.tight_layout()
    plt.savefig(output_path)
  