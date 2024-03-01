#!/bin/bash

# Ensure Poetry is installed
command -v poetry >/dev/null 2>&1 || { echo >&2 "Poetry is required but it's not installed. Aborting."; exit 1; }

# Initialize Poetry project (if not already a poetry project)
if [ ! -f "pyproject.toml" ]; then
    poetry init --no-interaction
fi

# Add Frictionless as a dependency
poetry add frictionless
