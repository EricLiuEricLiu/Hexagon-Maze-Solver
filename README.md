# Hexagon Maze Solver

## Description
Hexagon Maze Solver is a project that generates and solves hexagonal mazes. The project utilizes Processing to create a visual representation of the maze, with cells represented as hexagons. It employs a depth-first search algorithm to generate the maze and A* algorithm for solving it. The maze's start and end points, as well as the traversal path, are visually distinguished with different colors.

![Maze Image](https://github.com/EricLiuEricLiu/Hexagon-Maze-Solver/assets/40813414/5b428d0f-e52f-4fe8-a9da-6b41f48f08f6)

## Features
- Maze Generation using Depth-First Search Algorithm
- Maze Solving using A* Algorithm
- Visual Representation of Maze, Start & End Points, and Traversal Path
- Customizable Maze Size and Levels

## Files
- `maze.pde`: Contains the main logic for maze generation, solving, and visual representation.
- `Hex.pde`: Contains the Hex class definition used for representing individual hexagonal cells.

## Dependencies
- [Processing](https://processing.org/download/)

## Installation
1. Download and Install Processing from [here](https://processing.org/download/).
2. Clone the repo
3. Open maze.pde with Processing.
4. Run the file to see the maze generation and solving in action.

## Usage
- You can customize the size and levels of the maze by modifying the size and level variables in maze.pde.
- The colorList array allows you to change the colors used in the visual representation.
- The start and end variables can be adjusted to change the start and end points of the maze.

## Coordinate System

The Hexagon Maze Solver utilizes a unique coordinate system [level, side, number] for organizing and traversing the hexagonal maze. Here's a breakdown of the coordinate system:

1. **Level**:
   - `Level 1` represents the most centric cell.
   - `Level 2` comprises the 6 cells surrounding the central cell.
   - Subsequent levels envelop the previous ones with an additional ring of hexagons.

2. **Side**:
   - Each level is segmented into 6 sides, reflecting the hexagonal geometry.
   - Sides are indexed starting from the top-right, proceeding clockwise.

3. **Number**:
   - Each side on a given level contains `{level - 1}` number of cells.
   - This denotes the position of a cell along the side, with indexing starting at 0.

![Coordinate System](https://github.com/EricLiuEricLiu/Hexagon-Maze-Solver/assets/40813414/472c69c2-5e71-4881-8f1b-609df2d2e002)

