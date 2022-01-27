# Evo
Evolution, simulated.

Evo aims to simulate the process of evolution and learn some new things while doing it.

## Introduction to Evo
If you are going to simulate evolution you need something to evolve. Evo has two such entities: Vlems and Blargs.

Vlems are the plants of Evo and Blargs the animals. Each entity in Evo has unique attributes that help them survive, reproduce, pass along their attributes and adapt.

We just implicitly covered the 5 conditions essential to the evolutionary process but let's explicitly state them:

1. blueprints
2. self-replication
3. inheritance
4. mutation
5. selection

So Evo has to provide mechanism through which these things can happen. Here's how we do it.

### Blueprints
Blueprints are modeled through each entity's has set of attributes that are randomly generated and dictate how effective they are at surviving.

A few Blarg attributes are: visual acuity, speed, max size and color.

### Self-Replication
Not much to be done with blueprints unless you can replicate yourself. So each entity has the capacity to replicate through some reproductive strategy and thus produce offspring. Which leads us to our next condition.

### Inheritance

### Mutation

### Selection

At the time of this writing only a small part of EVO is built out.

## Getting Up & Running
As of Jan 27, 2022 Evo is just a functional core that we pass data through.

So right now you can do 1 of 3 things: run tests, play with functions already built in `iex`, or help build this thing.

  * Install dependencies: `mix deps.get`
  * Run tests: `mix test`
  * To play with code already written: `iex -S mix`
  * Help build this thing!

## Architectural Overview

