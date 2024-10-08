#!/usr/bin/env python3

# -----------------------------------------------------------------------------------------------------
# Elmer circuit builder main:
#
# Description:
#                This is a tool to write circuits in Elmer format using pin-connection convention.
#
# Instructions:
#                 1) Import the circuit builder library (from circuit_builder import *)
#                 2) Set output file name as a string (e.g output_file = "string_circuit.definitions")
#                 3) Set number of circuits with number_of_circuits(n) (e.g c = number_of_circuits(1))
#                 4) Set your ground/reference node in the current circuit c[1].ref_node = pin_number
#                 5) Select and configure electrical component
#                     Resistors (R), Inductors (L), Capacitors (C), Voltage Source (V), Current Source (I)
#                     or FEM Component (ElmerComponent)
#                     Arguments needed for R, L, C, V and I are the same. ElmerComponent takes additional arguments
#                 6) Add circuit components to circuit c[n].components.append([R1, V1, ElmerFemCoil, ...etc])
#                 7) Write circuits generate_elmer_circuits(c, output_file)
#                 8) Output file must be included in .sif file
#
# ------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------
# Imported Libraries:
import sys
import math
from elmer_circuitbuilder import *
# -----------------------------------------------------------------------------------------------------


def main(argv=None):

    # name output file
    output_file = "transient_2d_stranded_current_source.definition"

    # variables
    r_wire = 0.5e-3             # wire radius
    area   = math.pi*r_wire**2  # wire surface area
    sigma  = 5.8e7              # electrical conductivity
    rdc    = 1/(area*sigma)       # DC Resistance of Wire Rdc
    print("The DC Resistance of the wire is " + str(rdc))

    # initialize circuits: number of circuits - do not remove
    c = number_of_circuits(3)

 # ------------------ Circuit 1 (Current Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[1].ref_node = 2

    # Components

    # current source
    i1 = I("I1", 1, 2, 1)

    # massive coil positive terminal
    terminal_1p = ElmerComponent("T1p", 2, 1, 1, ["WIRE1"])
    terminal_1p.stranded(1,rdc)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[1].components.append([i1, terminal_1p])

    # --------------------------------------------------

    # ------------------ Circuit 2 (Current Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[2].ref_node = 2

    # Components

    # current source
    i2 = I("I2", 1, 2, 1)

    # massive coil positive terminal
    terminal_2p = ElmerComponent("T2p", 2, 1, 2, ["WIRE2"])
    terminal_2p.stranded(1, rdc)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[2].components.append([i2, terminal_2p])

    # --------------------------------------------------

    # ------------------ Circuit 3 (Current Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[3].ref_node = 2

    # Components

    # current source
    i3 = I("I3", 1, 2, 1)

    # massive coil positive terminal
    terminal_3p = ElmerComponent("T3p", 2, 1, 2, ["WIRE3"])
    terminal_3p.stranded(1, rdc)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[3].components.append([i3, terminal_3p])

    # --------------------------------------------------

    # generate elmer circuit.definitions - do not remove / do not edit
    generate_elmer_circuits(c, output_file)

    return 0


if __name__ == "__main__":
    sys.exit(main() or 0)

