import numpy as np
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers, models
from tensorflow.keras.datasets import mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(-1, 784).astype('float32') / 255.0
x_test = x_test.reshape(-1, 784).astype('float32') / 255.0

def create_model():
    model = models.Sequential()
    model.add(layers.Input(shape=(784,)))
    model.add(layers.Dense(50, activation='relu'))
    model.add(layers.Dense(20, activation='relu'))
    model.add(layers.Dense(10, activation='relu'))
    model.add(layers.Dense(10, activation='relu'))
    return model

model = create_model()

model.compile(
    loss=keras.losses.SparseCategoricalCrossentropy(),
    optimizer=keras.optimizers.Adam(),
    metrics=["accuracy"],)


model.fit(x_train, y_train, batch_size=128, epochs=20, validation_split=0.1)
test_loss, test_accuracy = model.evaluate(x_test, y_test)
print(f"Test loss: {test_loss}, Test accuracy: {test_accuracy}")

# Representative dataset generator for quantization
def representative_data_gen():
    for input_value in tf.data.Dataset.from_tensor_slices(x_train).batch(1).take(100):
        yield [tf.dtypes.cast(input_value, tf.float32)]

# Create a concrete function from the Keras model
@tf.function(input_signature=[tf.TensorSpec(shape=[None, 784], dtype=tf.float32)])
def model_func(inputs):
    return model(inputs)

concrete_func = model_func.get_concrete_function()

# Convert the model to a TensorFlow Lite model with int8 quantization
converter = tf.lite.TFLiteConverter.from_concrete_functions([concrete_func])
converter.optimizations = [tf.lite.Optimize.DEFAULT]
converter.representative_dataset = representative_data_gen
converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
converter.inference_input_type = tf.int8
converter.inference_output_type = tf.int8
quantized_tflite_model = converter.convert()

# Save the quantized model
with open("quantized_model_int8.tflite", "wb") as f:
    f.write(quantized_tflite_model)

# Evaluate the quantized model
def evaluate_tflite_model(tflite_model, x_test, y_test):
    # Initialize the TFLite interpreter
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()

    input_details = interpreter.get_input_details()
    output_details = interpreter.get_output_details()

    # Get input and output scales and zero points for quantization
    input_scale, input_zero_point = input_details[0]['quantization']
    output_scale, output_zero_point = output_details[0]['quantization']

    # Run predictions
    correct_predictions = 0
    for i in range(len(x_test)):
        # Normalize and quantize the input data
        input_data = np.expand_dims(x_test[i], axis=0).astype(np.float32)
        input_data = (input_data / input_scale + input_zero_point).astype(np.int8)
        
        interpreter.set_tensor(input_details[0]['index'], input_data)
        interpreter.invoke()
        output_data = interpreter.get_tensor(output_details[0]['index'])
        output_data = (output_data - output_zero_point) * output_scale

        if np.argmax(output_data) == y_test[i]:
            correct_predictions += 1

    quantized_accuracy = correct_predictions / len(x_test)
    return quantized_accuracy

quantized_accuracy = evaluate_tflite_model(quantized_tflite_model, x_test, y_test)
print(f"Quantized model accuracy: {quantized_accuracy}")


def save_weights_txt(model, filename):
    with open(filename + '_weights.txt', "w") as file:
        for layer in model.layers:
            if isinstance(layer, layers.Dense):
                weights = layer.get_weights()[0]
                biases = layer.get_weights()[1]
                np.savetxt(file, weights)
                np.savetxt(file, biases)

save_weights_txt(model, "test_model")

def save_quantized_weights(tflite_model, filename):
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()
    with open(filename + '_quantized_params.txt', "w") as file:
 
        for i, tensor_detail in enumerate(interpreter.get_tensor_details()):

            tensor_name = tensor_detail['name']
            
    
            tensor = interpreter.get_tensor(tensor_detail['index'])
            

            if 'kernel' in tensor_name or 'weight' in tensor_name:
                header = f"{tensor_name} (index: {i}, type: weight)"
            elif 'bias' in tensor_name:
                header = f"{tensor_name} (index: {i}, type: bias)"
            else:
                header = f"{tensor_name} (index: {i})"
                
            np.savetxt(file, tensor, header=header)
    
    # with open(filename + '_quantized_weights.txt', "w") as file:
    #     for i, tensor_detail in enumerate(interpreter.get_tensor_details()):
    #         tensor_name = tensor_detail['name']
    #         tensor = interpreter.get_tensor(tensor_detail['index'])
    #         np.savetxt(file, tensor, header=f"{tensor_name} (index: {i})")

save_quantized_weights(quantized_tflite_model, "quantized_model")

