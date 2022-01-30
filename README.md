# Evo
Evolution, simulated.

Evo aims to simulate the process of evolution and learn some new things while doing it. The goal is to do this by writing a functional core that models the game state with pure data and functions and ultimately represents the changing state with web technologies (such as liveview).

## Project Purpose
What started out as a personal project has been flipped to be used as a learning tool with our mentees at our weekly Elixir meetup.

## Introduction to Evo Concepts
If you are going to simulate evolution you need something to evolve. Evo has two such entities: Vlems and Blargs.

Vlems are the plants of Evo and Blargs the animals. Each entity in Evo has unique attributes that help them survive, reproduce, pass along their attributes and adapt.

We just implicitly covered the 5 conditions essential to the evolutionary process but let's explicitly state them here. They are:

1. Blueprints
2. Self-replication
3. Inheritance
4. Mutation
5. Selection

In order to simulate the evolutionary process Evo has to provide mechanisms through which these things can happen. An engine is programmed to drive each of these save for one property that is emergent from the others. Here's how we do it.

**1. Blueprints**

_**Blueprints**_ are modeled through each entity's set of attributes that are randomly generated. Those attributes dictate how effective they are at surviving.

A few Blarg attributes are: visual acuity, speed, max size and color.

**2. Self-Replication**

Not much to be done with blueprints unless _**Self-Replication**_ is a thing. So each entity has the capacity to replicate through some reproductive strategy and thus produce offspring. Which leads us to our next condition, inheritance.

**3. Inheritance**

Once entities replicate the _**Inheritance**_ process begins. To do this you combine the two sets of attributes that came together in the replication process and determine a random crossover point, this being the point which determines how much of each parent the child inherits.

Genes are switched after the crossover point in each pair. (paraphrased and quoted from wikipedia article sourced here: https://en.wikipedia.org/wiki/Inheritance_(genetic_algorithm))

**4. Mutation**

Finally, with the process of inheritance done, a _**Mutation**_ process is performed where genes are mutated randomly in the child. These mutations may be advantageous or not just like in the real world!

**5. Selection**

Finally that brings us to _**Selection**_, which is expressed incidentally in Evo through either successfully passing along genes/attributes to offspring or not. There isn't a single engine that handles this condition. Rather the property it is an emergent side effect of the simulation's engines and the dynamically shifting world.

## A Quick Code Tour
With the high level concepts out of the way that dictate Evo's structure and function, pop open your editor and take a look in `lib`.

There you'll find the entry point to the functional core in `evo.ex`. That leads you down to the `State` module which further leads down to the `Matrix` module which is what models the world in which the entities are born, grow, eat, live, struggle, reproduce, bear offspring, adapt, and ultimately die completing a life cycle.

The `entities` folder contains, you guessed it, the entities that make up the simulation.

The `engines` folder contains the engines that make the simulation run and make it dynamic.

## Getting Up & Running
As of Jan 27, 2022 Evo has just the most basic simulation state modeled. There is much to add and do!

So right now you can do 1 of 3 things: run tests, play with functions already built in `iex`, or help build this thing.

### Postgres Requirement
We expect that you have Postgres install and running. It is not currently needed so if you don't want to bother installing right now you can just comment out lines `4` to `10` in `dev.exs`

#### Installing Dependencies & Running Tests

  * Install dependencies: `mix deps.get`
  * Run tests: `mix test`
  * To play with code already written: `iex -S mix`
  * Help build this thing!

### Special Project Dependencies
#### Aja Vector
Aja Vector provides that data structure we use to model the coordinate plane in which the entities move. We needed constant time insertion for on any point in the data structure, Elixir's linked lists were too slow, so that's how we landed on this library.

[Aja Vector Docs](https://github.com/sabiwara/aja)

[Aja Vector Github](https://github.com/sabiwara/aja)

## Contributing/Collaborating
We'll use forks to all contribute back to the main repo. If you are unfamiliar with the workflow this is a great resource to get you started: [Fork Workflow Guide from Atlassian](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)
