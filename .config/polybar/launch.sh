#!/bin/bash

# Terminate already running bar instances
killall -w polybar

# Launch Polybar, using default config location ~/.config/polybar/config
polybar
