## 20 Games Challege Game #01: Flappy Bird
I'm taking on the [20 Games Challenge](https://20_games_challenge.gitlab.io) to learn more about game development, and more importantly to ship some games. This is game #1: Flappy Bird. 


## Requirements

- [PICO-8](https://www.lexaloffle.com/pico-8.php)
- Git (duh)

## Project Structure

```plaintext
flappy/
├── docs/                  # Lightweight notes and documentation
├── src/                   # Source code
│   ├── game_state.lua     # Game state / score manager
│   ├── gates.lua          # The area the player must pass through
│   ├── helpers.lua        # Helper functions
│   ├── player.lua         # Our hero
│   └── main.lua           # Entry point with _init, _update, _draw
├── flappy.p8              # Main P8 file; includes /src files
└── README.md              # Main project README
```

## Helpful Docs

- [20 Games Challege: Game 1](/docs/20-games-challenge.md): Outline of goals for this game from the 20 games challenge.
- [Project Plan](/docs/project-plan.md): Requirements, todos, and anything related to getting this project done.
- [Dev Log](/docs/devlog.md): A simple tracking of what I worked on in each session.