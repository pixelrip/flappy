# Dev Log
Total Time: 9hrs

## Day 3: 2025-10-08

- Pomodoros: X X X X - X X _ _ _ _
- Continue work on difficulty slope
    - Updating notes/thoughts in `difficulty.md`
    - Randomize gate sizing (w/h) scaled with difficulty
    - Simplified Y placement for now
    - Gate spawn time more dynamic
- On screen debugging



## Day 2: 2025-09-29

- Time worked: 4hrs
- Code review/small refactors
- Researching game difficulty curves
- Began integrating difficulty slope
- Introduced constants for easy gameplay tweaking `constants.lua`
- EOD status: WIP on the difficulty slope
    - Game speed: Done
    - Gate spawning: Not done
    - Gate height: Broken
    - Gate width: Broken


## Day 1: 2025-09-28

- Time worked: 5hrs
- Created temporary simple player sprite
- Create player object
- Created function to draw sprites based on object properties
- Simple gravity system in `gravity_system.lua`
- Added player input / flap
- Changed mind and removed gravity system in favor of letting the player handle its own gravity
- Limited the upward velocity possible
- Simple "gap" (pipe pairs) object
- Refactor: Gap -> Gates with gate spawning functionality
- Add gate collision and passing logic
- Add game state management and reset logic
- Added score tracking and display
- Refactor: Gate collision check into its own function
- Added game over message