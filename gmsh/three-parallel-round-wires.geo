// Three round wires example
// Author: Jonathan Velasco
// --------------------------------

// Parameters
r_wire = 0.5e-3;
r_wire1 = r_wire;
r_wire2 = r_wire;
r_wire3 = r_wire;
r_air = 3e-2;
vertical_distance = 1e-2;
turn_distance = 5*r_wire;

// Mesh control
lc_wire1 = r_wire1/6;
lc_wire2 = r_wire2/6;
lc_wire3 = r_wire3/6;
lc_air = r_air/6;

// Model's center point
Point(1) = {0, 0, 0, 1.0};

// Wire points

// Wire 1p
Point(2) = {turn_distance, vertical_distance, 0, lc_wire1}; // wire1p center point
Point(3) = {r_wire1+turn_distance, vertical_distance, 0, lc_wire1};
Point(4) = {turn_distance, r_wire1 + vertical_distance, 0, lc_wire1};
Point(5) = {-r_wire1+turn_distance, vertical_distance, 0, lc_wire1};
Point(6) = {turn_distance, -r_wire1 + vertical_distance, 0, lc_wire1};

// Wire 1m
Point(7) = {-turn_distance, vertical_distance, 0, lc_wire1}; // wire1m center point
Point(8) = {r_wire1-turn_distance, vertical_distance, 0, lc_wire1};
Point(9) = {-turn_distance, r_wire1 + vertical_distance, 0, lc_wire1};
Point(10) = {-r_wire1-turn_distance, vertical_distance, 0, lc_wire1};
Point(11) = {-turn_distance, -r_wire1 + vertical_distance, 0, lc_wire1};


// Wire 2p
Point(12) = {turn_distance, 0, 0, lc_wire2}; // wire1p center point
Point(13) = {r_wire2+turn_distance, 0, 0, lc_wire2};
Point(14) = {turn_distance, r_wire2, 0, lc_wire2};
Point(15) = {-r_wire2+turn_distance, 0, 0, lc_wire2};
Point(16) = {turn_distance, -r_wire2, 0, lc_wire2};

// Wire 2m
Point(17) = {-turn_distance, 0, 0, lc_wire2}; // wire1m center point
Point(18) = {r_wire2-turn_distance, 0, 0, lc_wire2};
Point(19) = {-turn_distance, r_wire2, 0, lc_wire2};
Point(20) = {-r_wire2-turn_distance, 0, 0, lc_wire2};
Point(21) = {-turn_distance, -r_wire2, 0, lc_wire2};

// Wire 3p
Point(22) = {turn_distance, -vertical_distance, 0, lc_wire3}; // wire3p center point
Point(23) = {r_wire3+turn_distance, -vertical_distance, 0, lc_wire3};
Point(24) = {turn_distance, r_wire3 - vertical_distance, 0, lc_wire3};
Point(25) = {-r_wire3+turn_distance, -vertical_distance, 0, lc_wire3};
Point(26) = {turn_distance, -r_wire3 - vertical_distance, 0, lc_wire3};

// Wire 3m
Point(27) = {-turn_distance, -vertical_distance, 0, lc_wire3}; // wire3m center point
Point(28) = {r_wire3-turn_distance, -vertical_distance, 0, lc_wire3};
Point(29) = {-turn_distance, r_wire3 - vertical_distance, 0, lc_wire3};
Point(30) = {-r_wire3-turn_distance, -vertical_distance, 0, lc_wire3};
Point(31) = {-turn_distance, -r_wire3 - vertical_distance, 0, lc_wire3};


// Air points
Point(32) = {r_air, 0, 0, lc_air};
Point(33) = {0, r_air, 0, lc_air};
Point(34) = {-r_air, 0, 0, lc_air};
Point(35) = {0, -r_air, 0, lc_air};


// Wire boundaries

// Wire 1p - TOP
Circle(1) = {3, 2, 4};
Circle(2) = {4, 2, 5};
Circle(3) = {5, 2, 6};
Circle(4) = {6, 2, 3};

// Wire 1p
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Wire 1m - TOP
Circle(5) = {8, 7, 9};
Circle(6) = {9, 7, 10};
Circle(7) = {10, 7, 11};
Circle(8) = {11, 7, 8};

// Wire 1m
Curve Loop(2) = {5, 6, 7, 8};
Plane Surface(2) = {2};

// Wire 2p - MIDDLE
Circle(9) = {13, 12, 14};
Circle(10) = {14, 12, 15};
Circle(11) = {15, 12, 16};
Circle(12) = {16, 12, 13};

// Wire 2p
Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {3};

// Wire 2m - MIDDLE
Circle(13) = {18, 17, 19};
Circle(14) = {19, 17, 20};
Circle(15) = {20, 17, 21};
Circle(16) = {21, 17, 18};

// Wire 2m
Curve Loop(4) = {13, 14, 15, 16};
Plane Surface(4) = {4};

// Wire 3p - BOTTOM
Circle(17) = {23, 22, 24};
Circle(18) = {24, 22, 25};
Circle(19) = {25, 22, 26};
Circle(20) = {26, 22, 23};


// Wire 3p
Curve Loop(5) = {17, 18, 19, 20};
Plane Surface(5) = {5};

// Wire 3m - BOTTOM
Circle(21) = {28, 27, 29};
Circle(22) = {29, 27, 30};
Circle(23) = {30, 27, 31};
Circle(24) = {31, 27, 28};

// Wire 3m
Curve Loop(6) = {21, 22, 23, 24};
Plane Surface(6) = {6};

// AIR/Infinity Boundary
Circle(25) = {32, 1, 33};
Circle(26) = {33, 1, 34};
Circle(27) = {34, 1, 35};
Circle(28) = {35, 1, 32};

// Air
Curve Loop(7) = {25, 26, 27, 28};
Plane Surface(7) = {1, 2, 3, 4, 5, 6, 7};


// Physical Entities

Physical Surface("WIRE1p", 17) = {1};
Physical Surface("WIRE1m", 18) = {2};

Physical Surface("WIRE2p", 19) = {3};
Physical Surface("WIRE2m", 20) = {4};

Physical Surface("WIRE3p", 21) = {5};
Physical Surface("WIRE3m", 22) = {6};

Physical Surface("AIR", 23) = {7};
Physical Curve("INFINITY", 24) = {25, 26, 27, 28};




