import numpy as np
import tensorflow as tf
from tensorflow import keras
from keras.datasets import mnist

#Load dataset as train and test sets
(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train = x_train.reshape(60000, 784)
x_test = x_test.reshape(10000, 784)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')
num_classes = 10# convert class vectors to binary class matrices
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

from keras.models import Sequential
from keras import models, layers
from keras import regularizers
model = Sequential()
model.add(layers.Dropout(0.2,input_shape=(784,)))
model.add(layers.Dense(1000,
                        kernel_regularizer = regularizers.l2(0.01),
                        activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(1000,
                        kernel_regularizer = regularizers.l2(0.01),
                        activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(10,  activation='softmax'))#display the model summary
model.summary()

model.compile(loss=keras.losses.categorical_crossentropy, 
              optimizer='adam', 
              metrics=['accuracy'])

hist = model.fit(x_train, y_train,
                        batch_size=128,
                        epochs=100,
                        verbose=1,
                        validation_data=(x_test,y_test))

score = model.evaluate(x_test, y_test, verbose=1)
print("Test loss {:.4f}, accuracy {:.2f}%".format(score[0], score[1] * 100))