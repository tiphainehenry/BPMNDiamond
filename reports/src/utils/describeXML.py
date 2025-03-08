import os
import xml.etree.ElementTree as ET
import pandas as pd

# Function to count BPMN elements
def count_bpmn_elements(xml_file):
    activities = 0
    start_events = 0
    end_events = 0
    gateways = 0
    throw_events = 0
    catch_events = 0
    pool_to_pool_flows = 0
    internal_flows = 0
    pools = 0
    data_objects = 0
    try:
        with open(xml_file, 'r', encoding='UTF-8') as file:
            tree = ET.parse(file)
            root = tree.getroot()

            ns = {'bpmn': 'http://www.omg.org/spec/BPMN/20100524/MODEL'}

            for process in root.findall('bpmn:process', ns):
                activities += len(process.findall('bpmn:task', ns))
                activities += len(process.findall('bpmn:subProcess', ns))
                activities += len(process.findall('bpmn:callActivity', ns))
                start_events += len(process.findall('bpmn:startEvent', ns))
                end_events += len(process.findall('bpmn:endEvent', ns))
                gateways += len(process.findall('bpmn:exclusiveGateway', ns))
                gateways += len(process.findall('bpmn:parallelGateway', ns))
                gateways += len(process.findall('bpmn:eventBasedGateway', ns))
                throw_events += len(process.findall('bpmn:intermediateThrowEvent', ns))
                catch_events += len(process.findall('bpmn:intermediateCatchEvent', ns))
                internal_flows += len(process.findall('bpmn:sequenceFlow', ns))

            for collaboration in root.findall('bpmn:collaboration', ns):
                pool_to_pool_flows += len(collaboration.findall('bpmn:messageFlow', ns))
                pools += len(collaboration.findall('bpmn:participant', ns))
                
            data_objects = len(root.findall('.//bpmn:dataObject', ns))
            
            return {
                'File Name': os.path.basename(xml_file),
                'Activities': activities,
                'Start Events': start_events,
                'End Events': end_events,
                'Gateways': gateways,
                'Throw Events': throw_events,
                'Catch Events': catch_events,
                'Pool-to-Pool Flows': pool_to_pool_flows,
                'Internal Flows': internal_flows,
                'Pools': pools,
                'Data Objects': data_objects
            }

    except FileNotFoundError:
        print(f'Error: The file "{xml_file}" does not exist.')
        return {'File Name': os.path.basename(xml_file), 'Activities': activities, 'Start Events': start_events, 'End Events': end_events, 'Gateways': gateways, 'Throw Events': throw_events, 'Catch Events': catch_events, 'Pool-to-Pool Flows': pool_to_pool_flows, 'Internal Flows': internal_flows, 'Pools': pools, 'Data Objects': data_objects}
    except ET.ParseError:
        print('Error: The XML file could not be parsed.')
        return {'File Name': os.path.basename(xml_file), 'Activities': activities, 'Start Events': start_events, 'End Events': end_events, 'Gateways': gateways, 'Throw Events': throw_events, 'Catch Events': catch_events, 'Pool-to-Pool Flows': pool_to_pool_flows, 'Internal Flows': internal_flows, 'Pools': pools, 'Data Objects': data_objects}
    except Exception as e:
        print(f'An unexpected error occurred: {e}')
        return {'File Name': os.path.basename(xml_file), 'Activities': activities, 'Start Events': start_events, 'End Events': end_events, 'Gateways': gateways, 'Throw Events': throw_events, 'Catch Events': catch_events, 'Pool-to-Pool Flows': pool_to_pool_flows, 'Internal Flows': internal_flows, 'Pools': pools, 'Data Objects': data_objects}

# Function to process BPMN files and compute complexity
def process_bpmn_files(directory):
    results = []

    for filename in os.listdir(directory):
        if filename.endswith('.xml') or filename.endswith('.bpmn'):
            file_path = os.path.join(directory, filename)
            result = count_bpmn_elements(file_path)
            
            # Compute complexity with updated formula
            w1, w2, w3, w4, w5, w6 = 1, 1, 2, 2, 1, 1  # Example weights
            result['Overall Complexity'] = (w1 * result['Activities'] +
                                            w2 * result['Gateways'] +
                                            w3 * (result['Throw Events'] + result['Catch Events']) +
                                            w4 * result['Pool-to-Pool Flows'] +
                                            w5 * result['Pools'] +
                                            w6 * result['Data Objects'])
            results.append(result)

    df = pd.DataFrame(results)
    max_complexity = df['Overall Complexity'].max()
    df['Normalized Complexity'] = df['Overall Complexity'] / max_complexity

    return df
