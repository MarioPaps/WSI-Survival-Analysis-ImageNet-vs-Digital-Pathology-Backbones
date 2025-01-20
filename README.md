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
3. Organise the extracted .pt feature files as follows:

```bash
ROOT_DIR/
    └──${TCGA_dataset}_${feature_extractor}_features/
            ├── slide_1.pt
            ├── slide_2.pt
            └── ...
```

### Training Code

- `blca_main_survival.py` is for training with the BLCA cohort
- `brca_main_survival.py` is for training with the BRCA cohort

For example, if we want to train using UNI as a backbone a MeanMIL model for the BLCA cohort, we can run the following bash script: 

```bash
#!/bin/bash

# Setting the hyperparameters
export backbone='uni_v1'   
export model_type='mean_mil'
export cancer_type=BLCA
export dropout=0.25
export lr=1e-4
export opt='adam'
export grad_accum_steps=32
export patience_epochs=10
export stop_epoch=40
export epochs=200
export reg=5e-4
export k=5
export mode='path'
export fusion='None'
export alpha_surv=0.0
export lambda_reg=1e-4
export bag_weight=0.7
export B=8
export patch_size=224
export preloading='no'
export in_dim=1024
export inst_loss='None'
export seed=1

# Construct the dynamic experiment code
export exp_code="${cancer_type}_${backbone}_${model_type}_dropout${dropout}_lr${lr}_opt${opt}_reg${reg}_$lreg{lambda_reg}_instloss${inst_loss}_patience${patience_epochs}_s${seed}"

# Run training

python blca_main_survival.py \
    --early_stopping \
    --data_root_dir "./${cancer_type}_uni_v1_features" \
    --results_dir "./${cancer_type,,}_results/${model_type}" \
    --max_epochs $epochs \
    --lr $lr \
    --batch_size 1 \
    --label_frac 1.0 \
    --reg $reg \
    --seed 1 \
    --k $k \
    --split_dir './splits/TCGA_BLCA_survival_kfold/' \
    --opt $opt --drop_out $dropout --gc $grad_accum_steps \
    --model_type $model_type\
    --mode $mode \
    --fusion 'None' \
    --exp_code $exp_code \
    --task 'survival' \
    --alpha_surv $alpha_surv \
    --patience $patience_epochs \
    --reg_type 'None' \
    --lambda_reg $lambda_reg \
    --bag_weight $bag_weight \
    --B $B \
    --patch_size $patch_size \
    --preloading 'no' \
    --in_dim $in_dim \
    --k_fold True \
    --inst_loss $inst_loss\
    --seed $seed
```

More examples for the BLCA cohort can be found in the training_scripts folder. By modifying the disease name and splits directory, an equivalent script can be obtained for other cohorts, such as BRCA. 



## Acknowledgements

Many thanks to the authors of  [CLAM](https://github.com/mahmoodlab/CLAM) and [MambaMIL](https://github.com/isyangshu/MambaMIL) for making their codebase open-source and accessible to other researchers.

## License & Citation

The work can be cited once it passess peer-review. 



