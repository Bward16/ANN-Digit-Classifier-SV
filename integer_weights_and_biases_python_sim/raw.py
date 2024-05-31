import numpy as np
from tensorflow.keras.datasets import mnist
from PIL import Image

# Load MNIST dataset
(train_images, train_labels), (test_images, test_labels) = mnist.load_data()

# Function to save MNIST images as raw data files
def save_mnist_image_as_raw(image, index):
    # Flatten the image to a single column of integers
    raw_data = image.flatten()
    
    # Save the raw data to a text file
    np.savetxt(f'mnist_image_{index}.txt', raw_data, fmt='%d')

# Save a couple of MNIST images as raw data files
for i in range(2):  # Change the range if you want to save more images
    save_mnist_image_as_raw(train_images[i], i)

print("MNIST images saved as raw data files successfully.")
