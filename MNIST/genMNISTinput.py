import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.datasets import mnist


(train_images, train_labels), (_, _) = mnist.load_data()

# Select a random image from the dataset
random_index = np.random.randint(0, train_images.shape[0])

static_index = 1234

random_image = train_images[static_index]
random_image_label = train_labels[static_index]

# Display the image
plt.imshow(random_image)

# Save the image to a file
plt.savefig('mnist_input_image.png')

# Save the pixel values to a text file
with open("mnist.txt", "w") as file:
    for row in random_image:
        for value in row:
            file.write(f"{value:.8f} ")  # Write each pixel value as float32
        file.write("\n")
