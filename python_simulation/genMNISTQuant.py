def save_quantized_weights(tflite_model, filename):
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()

    with open(filename + '_quantized_weights.txt', "w") as file:
        for i, tensor_detail in enumerate(interpreter.get_tensor_details()):
            tensor_name = tensor_detail['name']
            tensor = interpreter.get_tensor(tensor_detail['index'])
            np.savetxt(file, tensor, header=f"{tensor_name} (index: {i})")