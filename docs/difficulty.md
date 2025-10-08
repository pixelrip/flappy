# Difficulty

Some notes on how I'm thinking about difficulty in this game.

## Potential Difficulty Levers

1. Gate movement speed (faster = more difficult)
2. Gate height (smaller = more difficult)
3. Gate width (wider = more difficult)
4. Gate spawn timer / distance between gates (smaller = more difficult)

# Overall Difficulty Factor

The approach I've taken is to have a `base_difficulty` property in my main `game` object that acts as a multiplyer for the various "levers." 

```lua
-- /src/constants.lua
DIFFICULTY_INCREASE_RATE = 10

-- /src/game.lua
game.base_difficulty = 1 + flr(game.score / DIFFICULTY_INCREASE_RATE)

-- game.score = 0 -> game.difficulty = 1
-- game.score = 10 -> game.difficulty = 2
-- game.score = 50 -> game.difficulty = 6
```

# Difficulty Spikes
In order to keep the game from feeling too linear, I've introduced temporary difficulty spikes on a simple timer.

```lua

-- /src/game.lua
game.spike_modifer = SPIKE_DIFFICULTY
game.spike_timer = SPIKE_DURATION

-- Get effective difficulty during spikes
game.base_difficulty + game.spike_modifier
```


# Lever 1: Game Speed

The overall game speed also exists inside the main game object. It is a measure of pixels per frame (moving on the x axis). The speed is NOT imacted by the difficulty spikes (it feels far too unnatural).

```lua
-- /src/constants.lua
MAX_SPEED  = 5 
SPEED_INCREASE_RATE = 0.25 

-- /src/game.lua
get_speed = function(self)
    return min(MAX_SPEED, SPEED_INCREASE_RATE * self.base_difficulty + (1 - SPEED_INCREASE_RATE))
end
-- 
```

The primary impact of game speed on difficulty is how fast the gates move across the screen.

```lua
-- /src/gates.lua
gate.x -= game.get_speed()
```


# Lever 2: Gate Height

The "height" of the gate 


# Ensuring Fairness

To ensure fairness, we could base the `y` position of new gates on the `y` position of the previous gate. Assuming its physically possible for our player to cover the `y` distance in the time/distance between gates, we can call it "fair."

So how do we calculate the vertical distance the player can travel in the time it takes to get from one gate to the next? Here's our variables:

- Gravity (_gr) = 0.1
- Flap Strength (_fs) = -3.5
- Gate Speed (_gs) = 1 (pixel per frame)
- Gate spawn interval (_gs) = 90 (frames) - previous-gate-width