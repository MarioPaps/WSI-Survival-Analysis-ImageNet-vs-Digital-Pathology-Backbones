#!/bin/bash
#PBS -l select=1:ncpus=4:mem=64gb:ngpus=1
#PBS -lwalltime=02:10:00

cd $PBS_O_WORKDIR
cd ..

source $HOME/anaconda3/bin/activate
source activate mambamil

## Verify install:
python -c "import torch;print(torch.cuda.is_available())"

# Setting the hyperparameters
export backbone='Hibou-B'
export model_type=max_mil
export cancer_type=BLCA
echo $model_type
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
export in_dim=768
export inst_loss='None'


# Construct the dynamic experiment code
export exp_code="${cancer_type}_${backbone}_${model_type}_dropout${dropout}_lr${lr}_opt${opt}_reg${reg}_$lreg{lambda_reg}_instloss${inst_loss}_patience${patience_epochs}"
echo $exp_code
#Run training

python blca_main_survival.py \
    --early_stopping \
    --data_root_dir "./${cancer_type}_Hibou-B_features" \
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
    --model_type $model_type \
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
    --mambamil_rate 5 \
    --mambamil_layer 2 \
    --mambamil_type 'SRMamba'

