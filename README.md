# SLyGA
Solar Lyapunov Guidance Algorithm

This repo contains a MATLAB implementation of my undergraduate thesis. 

## Introduction
My thesis is about trajectory guidance for solar sail spacecraft in orbits around the Earth. My work figures out the best way to point a solar sail at a given instant in time, so that it can go from its current orbit to some target orbit.

* [See my one-pager description of the academic significance](https://github.com/itchono/SLyGA/files/12779364/Thesis_Proposal.pdf)

* [See my WIP notes for thesis here (late September 2023)](https://github.com/itchono/SLyGA/files/12779359/thesis_notes_sep_2023.pdf)

Below is an example of a trajectory I propagated which performs a three-dimensional orbital transfer using a Lyapunov steering law developed by me.

![trajectory plot](https://github.com/itchono/SLyGA/assets/54449457/661a9786-f4a2-41a4-b6e9-d3d812143e94)
![trajectory_animation](https://github.com/itchono/SLyGA/assets/54449457/103718fc-53da-43e3-b131-8695ff5a3cca)



## Installation and Setup
### Requirements
* MATLAB 2023a (Any recent version of MATLAB should work; but newer versions with ode89 and ode113 are best)

### Setup Procedure
1. Clone the repo
2. Open the root folder in MATLAB
3. Run `init.m` to perform setup. This needs to be run every time MATLAB is restarted.

## Code Structure
### `steering` - Steering Algorithms
This code computes the LVLH steering angle in which to point the sail. There are currently two components to the steering algorithm:
1. Lyapunov steering law - computes an optimal steering angle which decreases the control-Lyapunov potential function as quickly as possible
2. NDF Heuristic - accounts for the position of the Sun, and adapts the steering angle proposed by the Lyapunov steering law to something a solar sail can achieve. e.g. Feathering the sail if the desired pointing direction is directly toward the Sun.

### `sim` - Simulator
This folder includes equations of motion, ephemerides, and propulsion models.

Currently, there are two propulsion models implemented:
1. Constant thrust - thrusts in the direction of the sail normal vector with a constant magnitude
2. Solar sail - thrusts in the direction of the sail normal vector with a magnitude dependent on cone angle

`run_mission.m` connects all of the low-level ODEs and guidance stack together.

### `plotting` - Plotting Functions
Plotting from Modified Equinoctial Elements (MEEs).

### `printing` - Printing Functions
Displaying a summary of pre-mission and post-mission information

### `utils` - Utility Functions
This folder includes functions for converting between coordinate frames, computing orbital elements, and other miscellaneous functions.

## Usage
### `scripts/demo_plotter.m`
Orbit plotting demo

### `scripts/demo_mission.m`
Mission demo

## Code Formatting
Code is formatted using [MBeautifier](https://github.com/davidvarga/MBeautifier).

From the main folder, in the MATLAB command window, run:
`MBeautify.formatFiles(pwd, "*.m", true)` to format all .m files in the repo (takes about 1 minute)
