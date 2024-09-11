#!/bin/sh

# remove previous simulation results
rm -rf results_*

# run Elmer's simulation
#ElmerSolver current_massive.sif
#ElmerSolver current_stranded.sif

ElmerSolver voltage_massive.sif
ElmerSolver voltage_stranded.sif

# plot scalar results
python3 plot_results_data.py
