#!/bin/bash
# Copyright 2022 WONG YI HUNG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Illustrate the lists of quantise strategies
echo "Choose the quantise strategy"  
echo "pof2s: power-of-2 scale quantisation, mainly used for DPU targets now. Default quantise strategy of the quantiser."  
echo "pof2s_tqt: power-of-2 scale quantisation with trained thresholds, mainly used for QAT in DPU now."  
echo "fs: float scale quantisation, mainly used for devices supporting floating-point calculation, such as CPU/GPUs."  
echo "fsx: trained quantisation threshold for power-of-2 scale quantisation, mainly used for QAT for DPU now."  

#Decide a quantise strategy
read -r -p "Enter your choice of strategy (1)pof2s, (2)pof2s_tqt, (3)fs and (4)fsx: "  quantise_strategy
if [ "$quantise_strategy" = "1" ]
then
    quantise_strategy=pof2s
elif [ "$quantise_strategy" = "2" ]
then
    quantise_strategy=pof2s_tqt
elif [ "$quantise_strategy" = "3" ]
then
    quantise_strategy=fs
elif [ "$quantise_strategy" = "4" ]
then
    quantise_strategy=fsx
fi

#Decide a folder contains the image dataset
read -r -p "Enter the name of image dataset folder(N/n for default folder): " image_dataset
case ${image_dataset} in 
N | n)
    image_dataset=testm_val2017
esac

#Decide a weight name
read -r -p "Enter the selected weight name(N/n for default folder): " weight_name
case ${weight_name} in 
N | n)
    weight_name=yolov3.h5
esac

#Decide the name of xmodel output folder
read -r -p "Enter the name of xmodel output folder(N/n for default folder): " xmodel_folder
case ${xmodel_folder} in 
N | n)
    xmodel_folder=xmodel_folder
esac

#quantise model
python quantise.py --quantise_strategy $quantise_strategy --image_dataset $image_dataset --weight_name $weight_name

#transfer the quantised model into xmodel, and save the xmodel in the chosen folder
vai_c_tensorflow2 -m ./quantised_model.h5 -a ./meta.json -o ./$xmodel_folder --options '{"input_shape": "1,416,416,3"}' 
rm quantised_model.h5
