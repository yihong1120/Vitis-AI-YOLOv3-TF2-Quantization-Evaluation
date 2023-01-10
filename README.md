# Vitis-AI-YOLOv3-TF2-Quantization-Evaluation

This repository contains scripts and resources for evaluating quantization techniques for YOLOv3 object detection model on Vitis-AI using TensorFlow 2.x. The goal of this project is to explore the trade-offs between model performance and memory usage, providing a way to deploy the model on edge devices with limited resources.

## Getting Started

To run the scripts in this repository, you will need to have Vitis-AI, TensorFlow 2.x, and other dependencies installed on your system. You should also have an image dataset and a pre-trained YOLOv3 model in the format that the script expects.

## Scripts

* 'quantise.py': This script is used to quantize the model using the selected strategy.
* 'run.sh': This script is used to run the quantization process.

## Usage
This script is for running the evaluation of the quantized YOLOv3 model on Vitis-AI using TensorFlow 2.x inside a Docker container.

It starts by running the command docker_run.sh xilinx/vitis-ai-cpu:latest, which starts a Docker container based on the xilinx/vitis-ai-cpu:latest image. This image contains all the necessary tools and dependencies to run Vitis-AI and TensorFlow 2.x.

    ./docker_run.sh xilinx/vitis-ai-cpu:latest
    
Then it activates the Vitis-AI environment using conda activate vitis-ai-tensorflow2.

    conda activate vitis-ai-tensorflow2

After that, it changes the current directory to the model_zoo directory, and downloads a pre-trained YOLOv3 model from Xilinx's website, unzips it, and remove the zip file.

    cd model_zoo
    
Next, it changes the current directory to the code/test directory of the downloaded model, installs the required dependencies using pip install -r requirements.txt, and downloads and converts the dataset using the scripts download_data.sh and convert_data.sh.

    wget https://www.xilinx.com/bin/public/openDownload?filename=tf2_yolov3_coco_416_416_65.9G_2.5.zip
    unzip tf2_yolov3_coco_416_416_65.9G_2.5.zip
    rm -f tf2_yolov3_coco_416_416_65.9G_2.5.zip
    cd tf2_yolov3_coco_416_416_65.9G_2.5/code/test/
    pip install -r requirements.txt
    bash download_data.sh
    bash convert_data.sh

It runs the scripts run_eval_fmodel.sh and run_eval_qmodel.sh to evaluate the performance of the full-precision and quantized models, respectively. These scripts measure the accuracy of the models on the test dataset and display the results on the command line.
    
    bash run_eval_fmodel.sh
    bash run_eval_qmodel.sh

Please note that the pre-trained model and dataset used in this script might be out-dated and the instruction is for demonstration purpose only, you may need to download the latest model and dataset and adapt the command accordingly.

To run the quantization script and generate the xmodel to delopy on Xilinx FPGA, you can simply execute the command below in your terminal:

    ./run.sh

The script will prompt you for the following inputs:

1.  Quantization strategy (pof2s, pof2s_tqt, fs, fsx).
2.  Name of the image dataset folder (N/n for default folder).
3.  Selected weight name (N/n for default folder).
4.  Name of xmodel output folder (N/n for default folder)

Then the script will execute the 'quantise.py' script and transfer the quantized model into xmodel, and save the xmodel in the specified folder.

## Results

The result of the quantization will be stored in the specified xmodel output folder, along with the log file of the quantization process, it will show the statistics of the quantization such as precision, scale factor and etc.

Please note that the script is only for demonstration purpose, you may need to tweak the script for your specific use case.

## License

This project is licensed under the Apache 2.0 License

## Acknowledgements

Thank you to the Vitis-AI and TensorFlow teams for creating such powerful tools.
