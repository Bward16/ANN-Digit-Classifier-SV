# File: convert_to_hex.py

# Function to convert decimal to hex
def decimal_to_hex(decimal_value):
    return format(decimal_value, 'x')

# Read the input file
with open('MNIST_inputs.mem', 'r') as infile:
    decimal_values = infile.readlines()

# Convert decimal values to hex
hex_values = [decimal_to_hex(int(value.strip())) for value in decimal_values]

# Write the hex values to a new file
with open('MNIST_inputs_hex.mem', 'w') as outfile:
    for hex_value in hex_values:
        outfile.write(hex_value + '\n')

print("Conversion completed. Hex values are written to MNIST_inputs_hex.mem")
