import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

# Load MNIST dataset
mnist = tf.keras.datasets.mnist
(train_images, train_labels), (_, _) = mnist.load_data()

# Select a random image from the dataset
random_index = np.random.randint(0, train_images.shape[0])
random_image = train_images[random_index]
random_image_label = train_labels[random_index]

# Display the image
plt.imshow(random_image)

# Save the image to a file
plt.savefig('mnist_input_image.png')

# Rescale pixel values to the range [0, 1]
random_image = (random_image / 255.0)

# Save the pixel values to a text file
with open("mnist.txt", "w") as file:
    for row in random_image:
        for value in row:
            file.write(f"{value:.8f} ")  # Write each pixel value as float32
        file.write("\n")
