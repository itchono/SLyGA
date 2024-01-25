# SLyGA
Solar Lyapunov Guidance Algorithm

This repo contains a MATLAB implementation of my undergraduate thesis. 

## Introduction
My thesis is about trajectory guidance for solar sail spacecraft in orbits around the Earth. My work figures out the best way to point a solar sail at a given instant in time, so that it can go from its current orbit to some target orbit.

* [See my one-pager description of the academic significance](https://github.com/itchono/SLyGA/files/12779364/Thesis_Proposal.pdf)

* [See my interim writeup (late January 2024)](https://github.com/itchono/SLyGA/files/14046375/Thesis_Interim_Report_Shareable.pdf)

Below is an example of a trajectory I propagated which performs a three-dimensional orbital transfer using a Lyapunov steering law developed by me.

![trajectory plot](https://github.com/itchono/SLyGA/assets/54449457/9bc673e4-95c4-481e-a812-39a11eaad1b4)
![trajectory_animation](https://github.com/itchono/SLyGA/assets/54449457/ccc4bfdc-72cc-4612-a566-3d8ceb14f91c)



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
1. Modified Q Law - computes an optimal steering angle which decreases the control-Lyapunov potential function as quickly as possible
2. Steering Angle Regularization - accounts for the position of the Sun, and adapts the steering angle proposed by the Lyapunov steering law to something a solar sail can achieve. e.g. Feathering the sail if the desired pointing direction is directly toward the Sun.

### `sim` - Simulator
This folder includes equations of motion, ephemerides, and propulsion models used to "operate" the guidance law.

### `postprocess` - Postprocessing Functions
Used to interpolate, plot, and summarize the results of the simulations.

### `utils` - Utility Functions
This folder includes functions for converting between coordinate frames, computing orbital elements, and other miscellaneous functions.

### `scripts` - Case Files
Various simulation cases to run.

## Usage
1. Run one of the mission cases inside `scripts`.
2. Wait for the sim to finish. Then, run `postprocess` to show plots.
3. Data will be saved to the `outputs` folder.

## Code Formatting
Code is formatted using [MBeautifier](https://github.com/davidvarga/MBeautifier).

From the main folder, in the MATLAB command window, run:
`MBeautify.formatFiles(pwd, "*.m", true)` to format all .m files in the repo (takes about 1 minute)
