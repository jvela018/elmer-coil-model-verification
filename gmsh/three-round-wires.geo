// Three round wires example
// Author: Jonathan Velasco
// --------------------------------

// Parameters
r_wire = 0.5e-3;
r_wire1 = r_wire;
r_wire2 = r_wire;
r_wire3 = r_wire;
r_air = 3e-2;
distance = 1e-2;

// Mesh control
lc_wire1 = r_wire1/6;
lc_wire2 = r_wire2/6;
lc_wire3 = r_wire3/6;
lc_air = r_air/3;

// Model's center point
Point(1) = {0, 0, 0, 1.0};

// Wire points

// Wire 1
Point(2) = {0, distance, 0, lc_wire1}; // wire1 center point
Point(3) = {r_wire1, distance, 0, lc_wire1};
Point(4) = {0, r_wire1 + distance, 0, lc_wire1};
Point(5) = {-r_wire1, distance, 0, lc_wire1};
Point(6) = {0, -r_wire1 + distance, 0, lc_wire1};

// Wire 2
Point(7) = {0, 0, 0, lc_wire2}; // wire1 center point
Point(8) = {r_wire2, 0, 0, lc_wire2};
Point(9) = {0, r_wire2, 0, lc_wire2};
Point(10) = {-r_wire2, 0, 0, lc_wire2};
Point(11) = {0, -r_wire2, 0, lc_wire2};

// Wire 3
Point(12) = {0, -distance, 0, lc_wire3}; // wire1 center point
Point(13) = {r_wire3, -distance, 0, lc_wire2};
Point(14) = {0, r_wire3 - distance, 0, lc_wire2};
Point(15) = {-r_wire3, -distance, 0, lc_wire2};
Point(16) = {0, -r_wire3 - distance, 0, lc_wire2};


// Air points
Point(17) = {r_air, 0, 0, lc_air};
Point(18) = {0, r_air, 0, lc_air};
Point(19) = {-r_air, 0, 0, lc_air};
Point(20) = {0, -r_air, 0, lc_air};


// Wire boundaries

// Wire 1 - TOP
Circle(1) = {3, 2, 4};
Circle(2) = {4, 2, 5};
Circle(3) = {5, 2, 6};
Circle(4) = {6, 2, 3};


// Wire 2 - MIDDLE
Circle(5) = {8, 1, 9};
Circle(6) = {9, 1, 10};
Circle(7) = {10, 1, 11};
Circle(8) = {11, 1, 8};


// Wire 3 - BOTTOM
Circle(9) = {13, 12, 14};
Circle(10) = {14, 12, 15};
Circle(11) = {15, 12, 16};
Circle(12) = {16, 12, 13};


// AIR/Infinity Boundary
Circle(13) = {17, 1, 18};
Circle(14) = {18, 1, 19};
Circle(15) = {19, 1, 20};
Circle(16) = {20, 1, 17};

// Wire 1
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Wire 2
Curve Loop(2) = {5, 6, 7, 8};
Plane Surface(2) = {2};

// Wire 3
Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {3};

// Air
Curve Loop(4) = {13, 14, 15, 16};
Plane Surface(4) = {1, 2, 3, 4};

// Physical Entities

Physical Surface("WIRE1", 17) = {1};
Physical Surface("WIRE2", 18) = {2};
Physical Surface("WIRE3", 19) = {3};
Physical Surface("AIR", 20) = {4};
Physical Curve("INFINITY", 21) = {13, 14, 15, 16};
