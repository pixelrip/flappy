# Dev Log

## Day 2: 2025-09-29

- Code review/small refactors


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