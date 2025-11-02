# Snake Game in Terminal with Bash

This was a game inspired by the classic `Snake Game` that I tried to create using Bash Script. This was a good challenge because there were some complicated problems I needed to solve.

## Rendering System

The rendering system was designed with the following in mind:

- We will have a coordinate for a specific object.

- This object will have a corresponding character.

The coordinates are represented by a number that indicates the object's position on the screen, based on the number of columns in the terminal. For example, if the terminal has 20 columns, and the object's position is halfway down the second row, this would be represented by the coordinate 30 (20 columns for the first row, plus 10 for halfway down the second row).

To check which character should be placed in each position, four options are used:

- Snake's head: the last element in the list of positions that the snake occupies, represented by an at sign (@).

- Apple: is in a single variable, represented by the letter `p`.

- Snake's body: an element in the list of positions the snake occupies, represented by the letter `o`.

- Nothing: if the position is not related to any object, represented by a space.

## Input System

The input system was created using the Bash `read` command, but a timer was used in case nothing is pressed, and a one-character limit was applied.

To control the snake using the keyboard arrows, a second input was used, as they are represented by more than one character; for example, the up arrow is symbolized by `[[A`.

With the `stty -echo` command, executed at the beginning of the program, the user's input is not displayed in the terminal, avoiding visual errors during the game, but making it necessary to execute `stty echo` at the end of the program so that the user's terminal displays their inputs after the program has finished running.

## Game Movement, Winning, and Losing

The variable `snake_direction` determines the snake's movement, being:

1. Up
2. Down
3. Right
4. Left

When moving left and right, it's necessary to check if the snake's head is one line down or up, because if it is, it means the snake hit the edge of the screen. It's also necessary to check if the snake's head position is less than 0 or greater than the number of characters that fit in the terminal, as this would mean the snake went off the screen vertically.

The player only wins the game when all the characters on the screen are occupied by the snake's body.

It's possible to interrupt the game by pressing the `q` key, but this will not result in a win or loss.
