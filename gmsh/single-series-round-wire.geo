// Simple single round wire example
// Author: Jonathan Velasco
// --------------------------------

// Parameters
r_wire = 0.5e-3;
r_air = 20*r_wire;
turn_distance = 5*r_wire;

lc_wire = 1e-4;
lc_air = 1e-3;

// Model's center point
Point(1) = {0, 0, 0, 1.0};

// Wire1p
Point(2) = {turn_distance, 0, 0, lc_wire}; // center point
Point(3) = {r_wire+turn_distance, 0, 0, lc_wire};
Point(4) = {turn_distance, r_wire, 0, lc_wire};
Point(5) = {-r_wire+turn_distance, 0, 0, lc_wire};
Point(6) = {turn_distance, -r_wire, 0, lc_wire};

// Wire1m
Point(7) = {-turn_distance, 0, 0, lc_wire}; // center point
Point(8) = {r_wire-turn_distance, 0, 0, lc_wire};
Point(9) = {-turn_distance, r_wire, 0, lc_wire};
Point(10) = {-r_wire-turn_distance, 0, 0, lc_wire};
Point(11) = {-turn_distance, -r_wire, 0, lc_wire};


// Air points
Point(12) = {r_air, 0, 0, lc_air};
Point(13) = {0, r_air, 0, lc_air};
Point(14) = {-r_air, 0, 0, lc_air};
Point(15) = {0, -r_air, 0, lc_air};


// Wire1p boundaries
Circle(1) = {3, 2, 4};
Circle(2) = {4, 2, 5};
Circle(3) = {5, 2, 6};
Circle(4) = {6, 2, 3};

// Wire1m boundaries
Circle(5) = {8, 7, 9};
Circle(6) = {9, 7, 10};
Circle(7) = {10, 7, 11};
Circle(8) = {11, 7, 8};

// Infinity boundaries
Circle(9) = {12, 1, 13};
Circle(10) = {13, 1, 14};
Circle(11) = {14, 1, 15};
Circle(12) = {15, 1, 12};

// W1p
Curve Loop(1) = {4, 1, 2, 3};
Plane Surface(1) = {1};

// W1m
Curve Loop(2) = {5, 6, 7, 8};
Plane Surface(2) = {2};

// Air surface
Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {1, 2, 3};

// Physical Entities
Physical Surface("WIRE1p", 9) = {1};
Physical Surface("WIRE1m", 10) = {2};
Physical Surface("AIR", 11) = {3};
Physical Curve("INFINITY", 11) = {9, 10, 11, 12};

