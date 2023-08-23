# SLyGA
Solar Lyapunov Guidance Algorithm

This repo contains my MATLAB implementation of some algorithms for my thesis.

Below is an example of a trajectory I propagated which performs an orbit raising maneuver by toggling the solar sail between a face-on and edge-on orientation.

![image](https://github.com/itchono/SLyGA/assets/54449457/e499e450-79d0-4547-98ee-8c1abb50fb50)


# Installation and Setup
## Requirements
* MATLAB 2023a (Any recent version of MATLAB should work; but newer versions with ode89 and ode113 are best)

## Setup Procedure
1. Clone the repo
2. Open the root folder in MATLAB
3. Run `init.m` to perform setup. This needs to be run every time MATLAB is restarted.

# Code Structure
## `steering` - Steering Algorithms
This code computes the LVLH steering angle in which to point the sail. There are currently two algorithms implemented:
1. Simple Steering - attempts to point the sail prograde unless it produces backwards thrust, thereby always increasing the energy of the orbit
2. Lyapunov Steering - guidance law to converge towards a desired set of MEE elements

## `sim` - Simulator
This folder includes equations of motion, ephemerides, and propulsion models.

Currently, there are two propulsion models implemented:
1. Constant thrust - thrusts in the direction of the sail normal vector with a constant magnitude
2. Solar sail - thrusts in the direction of the sail normal vector with a magnitude dependent on cone angle

## `mission` - High Level Mission Runner
Connects all of the low-level ODEs and guidance stack together.

## `plotting` - Plotting Functions
Plotting from Modified Equinoctial Elements (MEEs).

## `utils` - Utility Functions
This folder includes functions for converting between coordinate frames, computing orbital elements, and other miscellaneous functions.

# Usage
## `scripts/demo_plotter.m`
Orbit plotting demo

## `scripts/demo_mission.m`
Mission demo

# Code Formatting
Code is formatted using [MBeautifier](https://github.com/davidvarga/MBeautifier).

From the main folder, in the MATLAB command window, run:
`MBeautify.formatFiles(pwd, "*.m", true)` to format all .m files in the repo (takes about 1 minute)
