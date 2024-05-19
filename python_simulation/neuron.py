import numpy as np

class SimpleNeuron:
    def __init__(self, weights, bias):
        self.weights = np.array(weights)
        self.bias = bias

    def feedforward(self, inputs):
        total = np.dot(self.weights, inputs) + self.bias
        return self.activation_function_ReLU(total)

    def activation_function_ReLU(self, x):
        return max(0, x)

class NeuralNetwork:
    def __init__(self, layer_config, weights, biases):
        self.layers = []
        for i in range(len(layer_config) - 1):
            layer = []
            for j in range(layer_config[i + 1]):
                neuron = SimpleNeuron(weights[i][j], biases[i][j])
                layer.append(neuron)
            self.layers.append(layer)

    def feedforward(self, inputs):
        for layer in self.layers:
            outputs = []
            for neuron in layer:
                output = neuron.feedforward(inputs)
                outputs.append(output)
            inputs = outputs  # The output of the current layer is the input to the next layer
        return inputs

#SIMPLE NUERON TESTING
weights = [1, 2, 3, 4]
bias = 1
neuron = SimpleNeuron(weights, bias)
inputs = [1, -2, -3, -4]
output = neuron.feedforward(inputs)
print(f"Output: {output}")


#NEURAL NETWORK TESTING
layer_config = [4, 4, 4, 4]  # Three layers with 4 neurons each
weights = [
    [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]],
    [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]],
    [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]
]
biases = [
    [1, 2, 3, 4],
    [1, 2, 3, 4],
    [1, 2, 3, 4]
]

nn = NeuralNetwork(layer_config, weights, biases)
inputs = [1, -2, -3, -4]
output = nn.feedforward(inputs)
print(f"Output: {output}")

# NEURAL NETWORK WITH 5 LAYERS
LAYERS = 5
LAYER_WIDTHS = [7, 7, 5, 2, 1, 1]

WEIGHTS = [
    [
        [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7],
        [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7],
        [1, 2, 3, 4, 5, 6, 7]
    ],
    [
        [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7],
        [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7]
    ],
    [
        [1, 2, 3, 4, 5], [1, 2, 3, 4, 5]
    ],
    [
        [1, 2]
    ],
    [
        [1]
    ]
]

BIASES = [
    [1, 2, 3, 4, 5, 6, 7],
    [1, 2, 3, 4, 5],
    [1, 2],
    [1],
    [1]
]


nn5 = NeuralNetwork(LAYER_WIDTHS, WEIGHTS, BIASES)
inputs = [1, -2, -3, -4, 5, 6, -7]
output = nn5.feedforward(inputs)
print(f"Output: {output}")