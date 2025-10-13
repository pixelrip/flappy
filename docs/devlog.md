# Dev Log
Total Time: 27.5hrs

### TODO:
- [ ] Title screen
- [ ] Update README.md with theme/thanks
- [ ] High score tracking
- [ ] Game over screen
- [ ] Music: Title
- [ ] Music: Gameplay
- [ ] Level progression (mountains -> city -> desert -> trees)
- [ ] Title screen

---

## Daily Notes

### Day 6: 2025-10-13
- Time worked: 3.5hrs
- Polish graphics for title screen
- Testing and implementing "Secret" color pallet in game
- Fix: Bird sprite
- WIP: Implementing ground, fence, cracks, barbed wire

### Day 5: 2025-10-10 

- Time worked: 7hrs
- [x] Mountains background w/ parallax
- [x] SFX: Flapping, collisions, point scored
- Chasing an potentially funny aestetic wild hair based on "Papers Please"
- Ok, it was worth it. [Mockup](/art/flappy-arstotzka.png)



### Day 4: 2025-10-09

- Time worked: 3hrs
- [x] Finish sprite states
- [x] Pipe art rendering
- [x] Player hitbox refactor
- [x] Sky and clouds background (parallax)

### Day 3: 2025-10-08

- Time worked: 5hrs
- Continue work on difficulty slope
    - Updating notes/thoughts in `difficulty.md`
    - Randomize gate sizing (w/h) scaled with difficulty
    - Simplified Y placement for now
    - Gate spawn time more dynamic
- On screen debugging
- Created a "moving" floor
- Updated `draw_sprite` to accept a transparent color number
- Add bird sprites to spritesheet
- EOD status: WIP on player sprite
    - State currently working but sprite position is always 0,0


### Day 2: 2025-09-29

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


### Day 1: 2025-09-28

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