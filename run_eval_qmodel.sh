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

export CUDA_VISIBLE_DEVICES=0

WEIGHTS=../../float/yolov3.h5
ANNO_JSON=../../data/annotations/instances_val2017.json
ANNO_FILE=../../data/val2017.txt
ANCHOR=configs/yolo3_anchors.txt
CLASSES=configs/coco_classes.txt
IOU_THRESH=0.45

###### generate prediction ######
python eval.py --model_path=${WEIGHTS} --anchors_path=${ANCHOR} --classes_path=${CLASSES} --model_input_shape=416x416 --nms_iou_threshold=${IOU_THRESH} --conf_threshold=0.001 --annotation_file=${ANNO_FILE} --save_result --quant --eval_only

###### eval with COCO official api ######
RES_TXT=result/detection_result.txt
RES_JSON=result/detection_result_iou${IOU_THRESH}.json
python tools/evaluation/pycoco_eval.py --result_txt ${RES_TXT} --coco_annotation_json ${ANNO_JSON} --coco_result_json ${RES_JSON}
