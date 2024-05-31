import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.datasets import mnist

# Load MNIST dataset
(train_images, train_labels), (test_images, test_labels) = mnist.load_data()

# Function to save MNIST images
def save_mnist_image(image, label, index):
    plt.imshow(image, cmap='gray')
    plt.title(f'Label: {label}')
    plt.axis('off')
    plt.savefig(f'mnist_image_{index}.png')
    plt.close()

# Save a couple of MNIST images
for i in range(2):  # Change the range if you want to save more images
    save_mnist_image(train_images[i], train_labels[i], i)

print("MNIST images saved successfully.")
