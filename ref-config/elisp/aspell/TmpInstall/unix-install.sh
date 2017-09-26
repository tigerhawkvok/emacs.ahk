#!/bin/sh
# Installation for *nix users
less Copyright
cp data/* `aspell config data-dir`
cp dict/* `aspell config dict-dir`
