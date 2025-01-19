# WSI-Survival-Analysis-ImageNet-vs-Digital-Pathology-Backbones

## Abstract
The abundance of information present in Whole Slide Images (WSIs) renders them an essential tool for survival analysis. Several Multiple Instance Learning (MIL) frameworks proposed for this task utilize
a ResNet50 backbone pre-trained on natural images. By leveraging recently released histopathological foundation models such as UNI and Hibou, the predictive prowess of existing MIL networks
can be enhanced. 
Furthermore, deploying an ensemble of digital pathology foundation models yields higher accuracy, although the benefits appear to diminish with more complex MIL architectures. 

## Installation and Virtual Environment Information

This project is implemented using PyTorch and requires a Python virtual environment with the following specifications:

- **Python Version**: 3.10
- **CUDA Version**: 11.8 (for GPU support)

### Key Dependencies
The most notable dependencies for this project include:

- `torch` 2.0.1
- `torchvision` 0.15.2
- `torchaudio` 2.0.2
-  `scikit-survival` 0.22.2   
Make sure to set up your virtual environment accordingly to ensure compatibility with the specified versions. A list of all dependencies can be found in the requirements.txt file.

## Code Execution

### Data Preparation
1. Download WSIs from TCGA
2. Use the CLAM framework to extract features at 10x resolution
3. Organise 

## Acknowledgements

Many thanks to the authors of  [CLAM](https://github.com/mahmoodlab/CLAM) and [MambaMIL](https://github.com/isyangshu/MambaMIL) for making their codebase open-source and accessible to other researchers.

## License & Citation

The work can be cited once it passess peer-review. 



