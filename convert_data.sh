# Copyright 2019 Xilinx Inc.
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

DATASET_PATH=../../data  ##DDATASET_PATH=data -> ATASET_PATH=../../data
OUTPUT_PATH=../../data  ##DDATASET_PATH=data -> ATASET_PATH=../../data
CODEBASE_DIR=./ #code/test  ##CODEBASE_DIR=./ -> CODEBASE_DIR=code/test
CLASSES=${CODEBASE_DIR}/configs/coco_classes.txt
python ${CODEBASE_DIR}/tools/dataset_converter/coco_annotation_val.py --dataset_path ${DATASET_PATH} --output_path ${OUTPUT_PATH} --classes_path ${CLASSES}

echo "Save result to ${OUTPUT_PATH}"
