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
    output_file = "transient_3d_stranded_voltage_source.definition"

    # initialize circuits: number of circuits - do not remove
    c = number_of_circuits(1)

 # ------------------ Circuit 1 (Voltage Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[1].ref_node = 2

    # Components

    # variables
    r_wire = 0.5e-3             # wire radius
    area   = math.pi*r_wire**2  # wire surface area
    sigma  = 5.8e7              # electrical conductivity
    rdc    = 1/(area*sigma)       # DC Resistance of Wire Rdc
    print("The DC Resistance of the wire is " + str(rdc))
    
    # electrode boundary index
    electrode_1 = 1 # WIRE_ELECTRODE_1
    electrode_2 = 2 # WIRE_ELECTRODE_2

    # current source
    v1 = V("V1", 1, 2, 1)

    # stranded coil positive terminal
    terminal_1p = ElmerComponent("T1p", 2, 1, 1, ["WIRE"])
    terminal_1p.stranded(1,rdc)
    terminal_1p.is3D()
    terminal_1p.isOpen(electrode_1,electrode_2)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[1].components.append([v1, terminal_1p])

    # --------------------------------------------------

    # generate elmer circuit.definitions - do not remove / do not edit
    generate_elmer_circuits(c, output_file)

    return 0


if __name__ == "__main__":
    sys.exit(main() or 0)

