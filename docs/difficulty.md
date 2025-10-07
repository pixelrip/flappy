# Difficulty

Some notes on how I'm thinking about difficulty in this game.

## Potential Difficulty Levers

1. Gate movement speed (faster = more difficult)
2. Gate height (smaller = more difficult)
3. Gate width (wider = more difficult)
4. Gate spawn timer / distance between gates (smaller = more difficult)

# Overall Difficulty Factor

One approach would be to tie some/all of the difficulty levers to a single `difficulty_factor`. It could be a function of the players score (which currently matches the number of gates they have successfully passed).

An exmaple of linear progression would look like this:

```lua
game.difficulty = 1 + flr(game.score / 10)

-- game.score = 0 -> game.difficulty = 1
-- game.score = 10 -> game.difficulty = 2
-- game.score = 50 -> game.difficulty = 6

```

# Ensuring Fairness

To ensure fairness, we could base the `y` position of new gates on the `y` position of the previous gate. Assuming its physically possible for our player to cover the `y` distance in the time/distance between gates, we can call it "fair."

So how do we calculate the vertical distance the player can travel in the time it takes to get from one gate to the next? Here's our variables:

- Gravity (_gr) = 0.1
- Flap Strength (_fs) = -3.5
- Gate Speed (_gs) = 1 (pixel per frame)
- Gate spawn interval (_gs) = 90 (frames) - previous-gate-width