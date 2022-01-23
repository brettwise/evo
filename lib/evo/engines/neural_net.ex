defmodule Evo.Engines.NeuralNet do
  @moduledoc """
  A neural net needs at least 3 layers to operate. They are called: input, hidden and output layers.

  Intro: https://en.wikipedia.org/wiki/Neural_network
  Feed-forward vs.Feedback/Recurrent NN: https://stats.stackexchange.com/q/2213
  Best vid we've found that breaks it down: https://www.youtube.com/watch?v=UNNKfNqr4kc

  Blarg inputs?
  - vision w/ a visual acuity modifier
    - what is vision? vision is simply how many coords a blarg can collect during a step
    aka how far they can "see"
  - hunger: movement takes energy, the lower the energy the greater the hunger
  - sex drive
    - sex drive only active if in sexual_maturity range

  Outputs?
  - rotate cc/cw
  - move forward
  - eat
  - mate

  Why hidden layers?
  https://deepai.org/machine-learning-glossary-and-terms/hidden-layer-machine-learning
  """
end
