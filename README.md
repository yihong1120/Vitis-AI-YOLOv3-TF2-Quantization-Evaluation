# Vitis-AI-YOLOv3-TF2-Quantization-Evaluation

This repository contains scripts and resources for evaluating quantization techniques for YOLOv3 object detection model on Vitis-AI using TensorFlow 2.x. The goal of this project is to explore the trade-offs between model performance and memory usage, providing a way to deploy the model on edge devices with limited resources.

## Getting Started

To run the scripts in this repository, you will need to have Vitis-AI, TensorFlow 2.x, and other dependencies installed on your system. You should also have an image dataset and a pre-trained YOLOv3 model in the format that the script expects.

## Scripts

* 'quantise.py': This script is used to quantize the model using the selected strategy.
* 'run.sh': This script is used to run the quantization process.

## Usage

To run the quantization script, you can simply execute the command below in your terminal:

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
