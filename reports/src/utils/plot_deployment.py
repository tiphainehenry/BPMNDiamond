import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

def plot_deployment_cost(df_diamond_deploy, df_mono_deploy, aggregate_choice, numModels, save_path):
    """
    Plot deployment cost with renamed stages for the diamond deployment.
    """
    # Define the stage renaming map
    stage_rename_map = {
        'diamond': 'Core Diamond',
        'BPMN logic facet': 'ExecLogicFacet',
        'BPMN factory facet': 'ModelFactoryFacet',
        'model': 'Model Registration',
        'instance': 'Model Instantiation'
    }

    # Create a figure and axes
    fig, ax = plt.subplots(figsize=(6.5, 3))
    bar_width = 0.4

    # Process Diamond DataFrame
    # Melt the Diamond DataFrame for stacking (using the index as modelName)
    df_diamond_melted = df_diamond_deploy.reset_index().melt(id_vars='modelName', var_name='stage', value_name='gas')
    
    # Rename the stages
    df_diamond_melted['stage'] = df_diamond_melted['stage'].replace(stage_rename_map)
    
    # Pivot for stacking and enforce the renamed order
    stacked_bars = df_diamond_melted.pivot_table(index='modelName', columns='stage', values='gas')
    stage_order_renamed = [stage_rename_map.get(stage, stage) for stage in [
        'diamond',
        'BPMN logic facet',
        'BPMN factory facet',
        'model',
        'instance'
    ]]
    pivot_df = stacked_bars[stage_order_renamed]
    
    # Plot the Diamond DataFrame with renamed stages
    pivot_df.plot(kind='bar', stacked=True, ax=ax, colormap='viridis', width=0.4, position=1)

    # Plot Monolithic Data
    bar_positions = np.arange(len(df_diamond_deploy))
    df_gas = df_mono_deploy.set_index('modelName').loc[df_diamond_deploy.index, 'gas']
    ax.bar(
        bar_positions + 0.2, 
        df_gas, 
        color='gray', 
        width=bar_width, 
        label='Monolithic', 
        alpha=0.7
    )

    # Set labels and legend
    ax.set_xlabel('')
    ax.set_ylabel('Gas Cost')
    
    paddingWidth = 1  # Sets legend to the right of the figure
    ax.legend(
        title="Deployment Stage",
        loc='upper left', 
        bbox_to_anchor=(paddingWidth, 1)
    )
    ax.tick_params(axis='x', rotation=45)
    
    # Set x-axis limits and save the figure
    plt.xlim([-0.5, numModels - 0.5])
    plt.tight_layout()
    plt.savefig(save_path)
