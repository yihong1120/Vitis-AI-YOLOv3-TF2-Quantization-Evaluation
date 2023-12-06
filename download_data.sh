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


DATA=data

CUR_DIR=$(pwd)
echo "Entering ${DATA}..."
cd ${DATA}

echo "Do you want to download COCO val2017 dataset?"
read -r -p "Enter 'Y' or 'y' to download, else use the data you have prepared in ${DATA}: " choice
case ${choice} in
Y | y)
    echo "Prepare to download COCO trainval2017 anotation zip file..."
    wget -c http://images.cocodataset.org/annotations/annotations_trainval2017.zip
    unzip annotations_trainval2017.zip
    rm -f annotations_trainval2017.zip
    
    echo "Prepare to download COCO val2017 image zip file..."
    wget -c http://images.cocodataset.org/zips/val2017.zip
    unzip val2017.zip
    rm -f val2017.zip;;
*)
    echo "Using data in ${DATA} you have prepared following the instruction in README.md";;
esac

echo "Entering ${CUR_DIR}"
cd ${CUR_DIR}

echo "Save results to ${DATA}"
