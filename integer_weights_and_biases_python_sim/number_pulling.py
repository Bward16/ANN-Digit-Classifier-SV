import numpy as np
import tensorflow as tf
import os

# Load MNIST data from tensorflow
(x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()

# Create directory if it doesn't exist
output_dir = 'images'
os.makedirs(output_dir, exist_ok=True)

# Select 100 sample images from the training set
sample_images = x_train[:100]
sample_labels = y_train[:100]

# Convert images to hex values and label them
hex_images = []
for img, label in zip(sample_images, sample_labels):
    hex_values = [format(int(pixel), '02x') for row in img for pixel in row]
    hex_images.append((label, hex_values))

# Create labeled files with hex values on new lines in the 'images' subdirectory
for idx, (label, hex_values) in enumerate(hex_images):
    file_name = f'{output_dir}/number_{idx}_{label}.txt'
    with open(file_name, 'w') as file:
        for hex_value in hex_values:
            file.write(f'{hex_value}\n')

# Write labels to a file in the 'images' subdirectory
labels_file = os.path.join(output_dir, 'labels.txt')
with open(labels_file, 'w') as file:
    for label in sample_labels:
        file.write(f'{label}\n')

print("Hex value files and labels file created successfully in the 'images' subdirectory.")
