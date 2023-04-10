# GO Analysis

<!-- PROJECT DESCRIPTION -->

This open-source code offers a comprehensive suite of tools to characterize a GO sheet in water and its dynamical features.

<!-- TABLE OF CONTENTS -->
## Table of Contents

- [GO Analysis](#go-analysis)
  - [Table of Contents](#table-of-contents)
  - [About the project](#about-the-project)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Usage](#usage)
  - [License](#license)
  - [Acknowledgments \& Sources](#acknowledgments--sources)

<!-- ABOUT THE PROJECT -->

## About the project

Using the positions and velocities provided from ab-initio molecular dynamics.

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

To use go_analysis, you need have a recent (supporting Fortran 2003) compiler

- gfortran or ifort
- make

### Installation

To download the project from Git, follow these steps:

1. Navigate to the project repository on Git.
2. Click on the "Code" button and copy the URL of the repository.
3. Open your terminal and navigate to the directory where you want to store the project.
4. Type `git clone` followed by the copied URL, and press Enter.

```sh
git clone https://github.com/your-username/your-project.git
```

This will download the project repository to your local machine.

To use Make for building and running the project, follow these steps:

1. Navigate to the project directory in your terminal.
2. Type `make` followed by the desired command and press Enter.

For example:

```sh
make all
```

will build the project using the Makefile. You can `make clean` (or `make realclean`) to clean up any objects/mod files (and executables).

<!-- USAGE EXAMPLES -->

## Usage

For each subprograms, the command is:

```sh
$(PATH_TO_BIN)\subprogram input_file
```

The input_file a formatted file, see folder for example inputs:

Common keywords:

| Keyword | Description |
|-|-|
| **file_pos** | Name of the coordinate file, in XYZ format, in Å |
| **file_vel** | Name of the velocities file, in XYZ format, in Å/fs |
| **file_is** | Name of the coordinate file for the instantaneous interface, in XYZ format, in Å |
| **nb_atm** | Number of atoms |
| **nb_step** | Number of frames to calculate the interface (starting from start) |
| **xlo,xhi,ylo,yhi,zlo,zhi** | Box boundaries, in Å |
| **suffix** | A suffix added to all output files (00) |
| **WRAP_C** | Center on the GO sheet (carbons) (Y for Yes (default), N for No)

Topological analysis: The first step is to use the program 'assign' to determine the type of specific atoms (e.g. oxygen in water, oxygen in an epoxide function, carbon carrying a ketone, etc.) and to generate position, velocity, and index files for the oxygen atoms in water molecules (for the calculation of the instantaneous interface).
An external program is required to calculate the instantaneous interface.

```sh
$(PATH_TO_BIN)\assign input_assign.txt
```

Specific keywords for assign:
| Keyword | Description |
|-|-|
| **assign_center_name** | Name of the atom for centering (C) |
| **assign_OC_rcut** | Cutoff in Å for a O-C bond (1.75) |
| **assign_OO_rcut** | Cutoff in Å for a O-O bond (1.75) |
| **assign_CC_rcut** | Cutoff in Å for a C-C bond (1.75) |
| **waterlist** | Print the index of water oxigen |

After performing the topological analysis and obtaining the transformed position/velocity files and the corresponding instantaneous interface file, you can use the other features of the go_analysis program.
Make sure that your position, velocities and surface files are wrapped around the same atoms. For your surface XYZ, use surface_wrap if needed.

<!-- LICENSE -->

## License

Distributed under the GNU Affero General Public License v3.0. See `LICENSE` for more information.

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments & Sources

This project has received official support from the [National Science Foundation](https://www.nsf.gov) under grant number [1845795].
