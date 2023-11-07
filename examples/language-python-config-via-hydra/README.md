# GOAL

Demonstrate Python Config via Hydra.

# Resources

Hydra Project Docs:
  https://hydra.cc/

Hydra source code (has examples in it)::
  https://github.com/facebookresearch/hydra

# Why is Hydra Compelling?

Show Answer:
  It's better (than similar options) and it's integral to NVIDIA Nemo.

Long Answer:
  Hydra can be used in a few ways.
  Details:
  - Parity with other config libraries:
    - It is simple/better way to handle
      configuration (as opposed to arg-parse)
    - It allows simple CLI overrides of config files.
  - Superior features
    - It can be used to change which config files
      are used, e.g. to put all "dev/prod" params
      together or "db-1/db-2/db-3" options can be kept
      in separate config files and selected easily.
    - It supports "sweeps" which support "AI/ML experiments"
      Sweeps allow running (and logging) with a RANGE of
      config options.
      This can be useful for AI work, but also for testing
      any range of supported configurations.
