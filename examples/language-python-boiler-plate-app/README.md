# GOAL

Create an example Python code set that shows how to:
- Run everything with one command (via Make and/or run.sh)
- Easily (and optionally) setup and use a Python virtual environment
- Optionally
  - Include Pythonic ways to manage:
    - Config
    - Logging
    - Testing
    - Linting
    - etc (add more here)

Any app/module should be able to "just work" with a single command.
It's almost always possible to avoid relying on documentation when
automation will work instead.

# WHAT THIS DOES

Demonstrate a simple pattern that supports:
- Manual/Old-School way of running things (without Make or run).
  The presence of the Makefile and run script does not affect the code.
  You can use these as just documentation if you want.
- The "run" script
  The run script is simply a boiler-plate skeleton that runs shell commands.
  It allows developers to iterate on it and run it quickly.
- "Make"
  Make adds dependency management and a single expected entry-point for everything.
  Make syntax makes it easy to define/document dependent steps.
  But, Make syntax can be a burden for new users.
  So, this example uses a simple Makefile that usually only calls "run".

# Requirements

- Bash
- Python3
- Make

# Steps to Run
```
make

# OR
pip install -r ./requirements.txt
python3 ./my_app.py

# OR
./run --build --test

# OR
./run -b -t

# OR
./run -b
./run -t
```
