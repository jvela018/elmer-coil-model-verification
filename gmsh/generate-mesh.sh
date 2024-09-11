#!/bin/sh

# create elmer mesh from gmsh .msh
gmsh single-round-wire.geo -2 single-round-wire.msh
gmsh three-round-wires.geo -2 three-round-wires.msh

gmsh single-series-round-wire.geo -2 single-series-round-wire.msh
gmsh three-series-round-wires.geo -2 three-series-round-wires.msh

# create single round wire mesh
ElmerGrid 14 2 single-round-wire.msh -2d –autoclean –names -out SINGLE_ROUND_WIRE

# three parallel wires
ElmerGrid 14 2 three-round-wires.msh -2d –autoclean –names -out THREE_ROUND_WIRES

# single series
ElmerGrid 14 2 single-series-round-wire.msh -2d –autoclean –names -out SINGLE_SERIES_ROUND_WIRE

# three series
ElmerGrid 14 2 three-series-round-wires.msh -2d –autoclean –names -out THREE_SERIES_ROUND_WIRES
