import numpy as np
import tensorflow as tf

# Path to your quantized TFLite model
tflite_model_path = "converted_quant_model.tflite"

# Load the TFLite model using the Interpreter
interpreter = tf.lite.Interpreter(model_path=tflite_model_path)
interpreter.allocate_tensors()  # Ensure tensors are allocated

# Get details for all tensors
tensor_details = interpreter.get_tensor_details()

# Prepare to display full arrays without truncation
np.set_printoptions(threshold=np.inf, linewidth=np.inf)  # Avoid truncation

# Helper function to format numpy arrays as SystemVerilog arrays
def format_sv_array(name, tensor):
    tensor = tensor.astype(int)  # Ensure the tensor values are integers
    
    if tensor.ndim == 1:  # 1D array case (biases)
        sv_output = f"parameter int {name} [{tensor.shape[0]}] = '{{"
        sv_output += ", ".join(map(str, tensor))
        sv_output += "};\n"
    elif tensor.ndim == 2:  # 2D array case (weights)
        sv_output = f"parameter int {name} [{tensor.shape[0]}][{tensor.shape[1]}] = '{{\n"
        for row in tensor:
            sv_output += "    '{"
            sv_output += ", ".join(map(str, row))
            sv_output += "}',\n"
        sv_output += "};\n"
    else:
        raise ValueError("Tensor dimensionality not supported")
    
    return sv_output

# Iterate over each tensor and format for SystemVerilog
for detail in tensor_details:
    if 'MatMul' in detail['name'] or 'BiasAdd' in detail['name']:
        # Retrieve the tensor data using the tensor index
        tensor = interpreter.get_tensor(detail['index'])
        
        # Print the layer name and tensor details
        print(f"// Layer: {detail['name']}")
        print("Shape:", detail['shape'])
        
        # Check if the tensor has quantization parameters
        if detail['quantization_parameters']:
            print("Quantized Scale:", detail['quantization_parameters']['scales'])
            print("Quantized Zero Point:", detail['quantization_parameters']['zero_points'])
        
        print("Tensor Values:")
        # Format the tensor as a SystemVerilog array
        layer_name = detail['name'].replace('/', '_').replace('ReadVariableOp', '')
        sv_formatted_array = format_sv_array(layer_name, tensor)
        print(sv_formatted_array)
