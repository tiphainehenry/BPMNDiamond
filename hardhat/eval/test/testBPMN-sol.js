const { compile } = require('../../volatile/home/vl278331/diamond-2-hardhat/BPMN-Sol/src/index.ts')
describe('BPMN', async function () {
    let XML
    let compiled
    before(async function () {
        XML={
            bpmn: '<?xml version="1.0" encoding="UTF-8"?><bpmn:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" xmlns:di="http://www.omg.org/spec/DD/20100524/DI" id="Definitions_05pjfbo" targetNamespace="http://bpmn.io/schema/bpmn" exporter="bpmn-js (https://demo.bpmn.io)" exporterVersion="17.7.1"> <bpmn:process id="Process_020s6es" isExecutable="false"> <bpmn:startEvent id="StartEvent_00vcx4d"> <bpmn:outgoing>Flow_1n9mlho</bpmn:outgoing> </bpmn:startEvent> <bpmn:task id="Activity_1n5m473"> <bpmn:incoming>Flow_1n9mlho</bpmn:incoming> <bpmn:outgoing>Flow_1042252</bpmn:outgoing> </bpmn:task> <bpmn:sequenceFlow id="Flow_1n9mlho" sourceRef="StartEvent_00vcx4d" targetRef="Activity_1n5m473" /> <bpmn:endEvent id="Event_07dx314"> <bpmn:incoming>Flow_1042252</bpmn:incoming> </bpmn:endEvent> <bpmn:sequenceFlow id="Flow_1042252" sourceRef="Activity_1n5m473" targetRef="Event_07dx314" /> </bpmn:process> <bpmndi:BPMNDiagram id="BPMNDiagram_1"> <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_020s6es"> <bpmndi:BPMNShape id="_BPMNShape_StartEvent_2" bpmnElement="StartEvent_00vcx4d"> <dc:Bounds x="152" y="102" width="36" height="36" /> </bpmndi:BPMNShape> <bpmndi:BPMNShape id="Activity_1n5m473_di" bpmnElement="Activity_1n5m473"> <dc:Bounds x="240" y="80" width="100" height="80" /> </bpmndi:BPMNShape> <bpmndi:BPMNShape id="Event_07dx314_di" bpmnElement="Event_07dx314"> <dc:Bounds x="392" y="102" width="36" height="36" /> </bpmndi:BPMNShape> <bpmndi:BPMNEdge id="Flow_1n9mlho_di" bpmnElement="Flow_1n9mlho"> <di:waypoint x="188" y="120" /> <di:waypoint x="240" y="120" /> </bpmndi:BPMNEdge> <bpmndi:BPMNEdge id="Flow_1042252_di" bpmnElement="Flow_1042252"> <di:waypoint x="340" y="120" /> <di:waypoint x="392" y="120" /> </bpmndi:BPMNEdge> </bpmndi:BPMNPlane> </bpmndi:BPMNDiagram></bpmn:definitions>',
            name: 'test3' 
        }

    })

    it('mesure de Gas avec Abi facet entiere', async () =>{
        compiled =await compile(XML)
            .then(contract => {
            console.log(contract);
            })
            .catch(error => {
             console.log(error)
            })

        })
        console.log(compiled)
})