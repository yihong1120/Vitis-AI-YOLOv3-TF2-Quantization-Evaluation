import tensorflow as tf
import keras, os, argparse
from tensorflow_model_optimization.quantization.keras import vitis_quantize
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img

#input the parametres
parser = argparse.ArgumentParser()
parser.add_argument(
        '--quantise_strategy', type=str,
        help='quantise strategy', default='fs') #pof2s
parser.add_argument(
        '--image_dataset', type=str,
        help='image dataset for calibrating', default='calibration_dataset')
parser.add_argument(
        '--model_name', type=str,
        help='the name of input model', default='dump_model.h5')
parser.add_argument(
        '--output_model', type=str,
        help='the name of output quantised model', default='quantised_model.h5')
parser.add_argument(
        '--quantise_type', type=str,
        help='determine if you would like to do quick quantise', default='general_quantisation')
parser = parser.parse_args()

#product the file routes
root_path = os.getcwd() 
calibration_dataset_path = os.path.join(root_path, parser.image_dataset)
origin_model_path = os.path.join(root_path, parser.model_name)
quantised_model_path = os.path.join(root_path, parser.output_model)

#image data augmentation
calibration_datagen = ImageDataGenerator(
        fill_mode = 'nearest'
        
	rotation_range = 40,
	width_shift_range = 0.2,
	height_shift_range = 0.2,
	shear_range = 0.2,
	zoom_range = 0.2,
	horizontal_flip = True,
        fill_mode = 'nearest',
        rescale = 1./255
	)

#read the image dataset and resize the images
calibration_generator = calibration_datagen.flow_from_directory(
        calibration_dataset_path,
        target_size=(224, 224)
        ) 

#compile the model from .h5 file
model = tf.keras.models.load_model(origin_model_path, compile = False)
model.compile(
        optimizer=tf.keras.optimizers.Adam(),
        loss=tf.keras.losses.SparseCategoricalCrossentropy(),
        metrics=[tf.keras.metrics.SparseCategoricalAccuracy()],
)

#quantise the .h5 model
quantizer = vitis_quantize.VitisQuantizer(
        model, quantize_strategy = parser.quantise_strategy
        ) #, quantize_strategy='fs,x' pof2s

#general quantisation
if parser.quantise_type == "general_quantisation":
        quantized_model = quantizer.quantize_model(
                calib_dataset = calibration_generator,
                #input_bit = 8,
                verbose = 1
        )
#quick quantisation of the .h5 model  
elif parser.quantise_type == "quick_quantisation":                               
        quantized_model = quantizer.quantize_model(
                calib_dataset = calibration_generator,
                #calib_step=None, 
                calib_batch_size=None, 
                include_fast_ft=True, 
                fast_ft_epochs=10
        ) #**kwargs

#save the quantised model
quantized_model.save(quantised_model_path)
