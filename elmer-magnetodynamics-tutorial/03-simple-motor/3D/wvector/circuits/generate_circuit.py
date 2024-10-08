#!/usr/bin/env python3

# -----------------------------------------------------------------------------------------------------
# This modified script generates a three phase transient voltage source connected in series with two components at a time
# Author: Jonathan Velasco
# -----------------------------------------------------------------------------------------------------

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
    output_file = "transient_3d_stranded_3ph_voltage_source2.definition"

    # variables
    r_wire = 0.5e-3             # wire radius
    area   = math.pi*r_wire**2  # wire surface area
    sigma  = 5.8e7              # electrical conductivity
    rdc    = 1/(area*sigma)       # DC Resistance of Wire Rdc
    nturns = 20

    # boundary numbers
    #
    winding_a_plus_electrode_1 = 3
    winding_b_minus_electrode_1 = 9
    winding_c_plus_electrode_1 = 15
    winding_a_minus_electrode_1 = 22
    winding_b_plus_electrode_1 = 28
    winding_c_minus_electrode_1 = 34
    winding_a_plus_electrode_2 = 4
    winding_b_minus_electrode_2 = 10
    winding_c_plus_electrode_2 = 16
    winding_a_minus_electrode_2 = 23
    winding_b_plus_electrode_2 = 29
    winding_c_minus_electrode_2 = 35



    print("Using stranded coil with " + str(nturns) + " turns")
    print("The DC Resistance of the wire is " + str(rdc))

    # initialize circuits: number of circuits - do not remove
    c = number_of_circuits(3)

 # ------------------ Circuit 1 (Voltage Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[1].ref_node = 2

    # Components

    # voltage source
    v1 = V("V1", 1, 2, 1e3)

    # stranded coil positive terminal
    terminal_1p = ElmerComponent("T1p", 3, 1, 1, ["winding_a_plus"])
    terminal_1p.stranded(nturns,rdc)
    terminal_1p.is3D()
    terminal_1p.isOpen(winding_a_plus_electrode_1,winding_a_plus_electrode_2)

    # stranded coil negative terminal
    terminal_1m = ElmerComponent("T1m", 3, 2, 2, ["winding_a_minus"])
    terminal_1m.stranded(nturns,rdc)
    terminal_1m.is3D()
    terminal_1m.isOpen(winding_a_minus_electrode_1,winding_a_minus_electrode_2)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[1].components.append([v1, terminal_1p, terminal_1m])

    # --------------------------------------------------

    # ------------------ Circuit 2 (Voltage Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[2].ref_node = 2

    # Components

    # voltage source
    v2 = V("V2", 1, 2, 1e3)

    # stranded coil positive terminal
    terminal_2p = ElmerComponent("T2p", 3, 1, 3, ["winding_b_plus"])
    terminal_2p.stranded(nturns,rdc)
    terminal_2p.is3D()
    terminal_2p.isOpen(winding_b_plus_electrode_1,winding_b_plus_electrode_2)

    # stranded coil negative terminal
    terminal_2m = ElmerComponent("T2m", 3, 2, 4, ["winding_b_minus"])
    terminal_2m.stranded(nturns,rdc)
    terminal_2m.is3D()
    terminal_2m.isOpen(winding_b_minus_electrode_1,winding_b_minus_electrode_2)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[2].components.append([v2, terminal_2p, terminal_2m])

    # --------------------------------------------------

    # ------------------ Circuit 3 (Voltage Source - Transient)---------------------

    # reference/ground node needed - do not remove.
    c[3].ref_node = 2

    # Components

    # voltage source
    v3 = V("V3", 1, 2, 1e3)

    # stranded coil positive terminal
    terminal_3p = ElmerComponent("T3p", 3, 1, 5, ["winding_c_plus"])
    terminal_3p.stranded(nturns,rdc)
    terminal_3p.is3D()
    terminal_3p.isOpen(winding_c_plus_electrode_1,winding_c_plus_electrode_2)

    # stranded coil negative terminal
    terminal_3m = ElmerComponent("T3m", 3, 2, 6, ["winding_c_minus"])
    terminal_3m.stranded(nturns,rdc)
    terminal_3m.is3D()
    terminal_3m.isOpen(winding_c_minus_electrode_1,winding_c_minus_electrode_2)

    # store components in array components = [comp1, comp2,...] - do not remove
    c[3].components.append([v3, terminal_3p, terminal_3m])
    # --------------------------------------------------

    # generate elmer circuit.definitions - do not remove / do not edit
    generate_elmer_circuits(c, output_file)

    return 0


if __name__ == "__main__":
    sys.exit(main() or 0)

