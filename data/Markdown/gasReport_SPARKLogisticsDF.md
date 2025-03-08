## Methods
| **Symbol** | **Meaning**                                                                              |
| :--------: | :--------------------------------------------------------------------------------------- |
|    **◯**   | Execution gas for this method does not include intrinsic gas overhead                    |
|    **△**   | Cost was non-zero but below the precision setting for the currency display (see options) |

|                       |    Min |     Max |        Avg | Calls | usd avg |
| :-------------------- | -----: | ------: | ---------: | ----: | ------: |
| **DiamondCutFacet**   |        |         |            |       |         |
|        *diamondCut*   |      - |       - |  1,116,099 |     2 |       - |
| **ExecLogicFacet**    |        |         |            |       |         |
|        *Invoke*       | 46,147 | 812,473 |    454,397 |    27 |       - |
| **ModelFactoryFacet** |        |         |            |       |         |
|        *addModel*     |      - |       - | 20,285,991 |     1 |       - |
|        *newInstance*  |      - |       - |  1,021,970 |     2 |       - |

## Deployments
|                         | Min | Max  |       Avg | Block % | usd avg |
| :---------------------- | --: | ---: | --------: | ------: | ------: |
| **Diamond**             |   - |    - |   274,481 |   0.9 % |       - |
| **DiamondCutFacet**     |   - |    - |   777,018 |   2.6 % |       - |
| **DiamondInit**         |   - |    - | 1,568,463 |   5.2 % |       - |
| **DiamondLoupeFacet**   |   - |    - |   658,220 |   2.2 % |       - |
| **ExecLogicFacet**      |   - |    - | 3,140,809 |  10.5 % |       - |
| **ExecLogicFacetV2**    |   - |    - |   726,811 |   2.4 % |       - |
| **GettersFacet**        |   - |    - |   837,766 |   2.8 % |       - |
| **GettersFacetV2**      |   - |    - |   551,451 |   1.8 % |       - |
| **LibAppV2**            |   - |    - |    72,227 |   0.2 % |       - |
| **ModelFactoryFacet**   |   - |    - | 1,004,674 |   3.3 % |       - |
| **ModelFactoryFacetV2** |   - |    - |   807,384 |   2.7 % |       - |
| **OwnershipFacet**      |   - |    - |   179,513 |   0.6 % |       - |

## Solidity and Network Config
| **Settings**        | **Value**  |
| ------------------- | ---------- |
| Solidity: version   | 0.8.24     |
| Solidity: optimized | true       |
| Solidity: runs      | 200        |
| Solidity: viaIR     | false      |
| Block Limit         | 30,000,000 |
| Gas Price           | -          |
| Token Price         | -          |
| Network             | ETHEREUM   |
| Toolchain           | hardhat    |

