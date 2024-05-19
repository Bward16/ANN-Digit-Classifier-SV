import numpy as np
from tensorflow import keras
from tensorflow.keras import layers, models
from tensorflow.keras.datasets import mnist

# Load MNIST dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(-1, 784).astype('float32') / 255.0
x_test = x_test.reshape(-1, 784).astype('float32') / 255.0

# Test Model
test_model = models.Sequential()
test_model.add(layers.Input(shape=(784,)))
test_model.add(layers.Dense(50, activation='relu'))
test_model.add(layers.Dense(20, activation='relu'))
test_model.add(layers.Dense(10, activation='relu'))
test_model.add(layers.Dense(10, activation='relu'))

# Compile models
test_model.compile(
    loss=keras.losses.SparseCategoricalCrossentropy(),
    optimizer=keras.optimizers.Adam(),
    metrics=["accuracy"],
)


# Save weights as .txt files
def save_weights_txt(model, filename):
    with open(filename + 'weight.txt', "w") as file:
        for layer in model.layers:
            if isinstance(layer, layers.Dense):
                weights = layer.get_weights()[0]
                biases = layer.get_weights()[1]
                np.savetxt(file, weights)
                np.savetxt(file, biases)


test_model.fit(x_train, y_train, batch_size=128, epochs=20, validation_split=0.1)
test_loss, test_accuracy = test_model.evaluate(x_test, y_test)
print(test_loss, test_accuracy)
save_weights_txt(test_model, "test_model")
