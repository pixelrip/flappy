# 20 Games Challege Game #01: Flappy Bird

A simple Flappy Bird clone from [Arstotzka](https://papersplea.se) ported to PICO-8. 

## The 20 Games Challenge

In Sept 2025 I found myself deep into learning about game development without actually shipping or sharing many games. Enter the [20 Games Challenge](https://20_games_challenge.gitlab.io). To tackle this audacious and overwhelming challenge I set a few constraints:

1. Complete each game (or working vertical slice of a game) in 60 hours
2. Use [PICO-8](https://www.lexaloffle.com/dl/docs/pico-8_manual.html) as my game engine
3. Post each completed cart on the [Lexaloffle PICO-8 forum](https://www.lexaloffle.com/bbs/?cat=7) for feedback
4. Track hours and progress in a simple [devlog](/docs/devlog.md)
5. Revisit the scope and constraints for games 11-20 after completing 1-10

My goal is to learn and practice more "professional" patterns (forward thinking, extensible code) in game programming while balancing the need to ship actual games.


## Game Fiction

On a recent trip to Arztotska I discovered the wild amount of knock-off products lining street merchant stalls all throughout the capitol city. I brought a few nick nacks home, but my favorite had to be this "Flappy Bird" knock-off game cart for the ancient Kvant-IG80 console. 

The game instuctions were simple enough to translate: "Press ❎ to fly your magestic Arstotzkan eagle into the heart of our great nation. Glory to Arztotzka." I have yet to make it to the "heart"--frankly I don't think there is an end to the game.


## Requirements

- [PICO-8](https://www.lexaloffle.com/pico-8.php)
- Git (duh)

## Project Structure

```plaintext
flappy/
├── art/                   # Mockups, custom colors
├── docs/                  # Lightweight notes and documentation
├── src/                   # Source code
│   ├── *.lua              # Various game "modules"
│   └── main.lua           # Entry point with _init, _update, _draw
├── flappy.p8              # Main P8 file; includes /src files
└── README.md              # Main project README
```

## Context Docs

- [20 Games Challege: Game 1](/docs/20-games-challenge.md): Outline of goals for this game from the 20 games challenge.
- [Dev Log](/docs/devlog.md): A simple tracking of what I worked on in each session.

## Acknowlegements

Obviously, I've borrowed mechanics from [Flappy Bird](https://en.wikipedia.org/wiki/Flappy_Bird) and themes from the game world of [Papers, Please](https://papersplea.se) by [Lucas Pope](https://www.dukope.com) (which I consider one of the best video games ever created). If for some reason you haven't played Papers, Please stop wasting your time here and go buy a copy: [iOS](https://apps.apple.com/us/app/papers-please/id935216956?ls=1), [Android](https://play.google.com/store/apps/details?id=com.llc3909.papersplease), [Steam](http://store.steampowered.com/app/239030), [Humble](https://www.humblebundle.com/store/p/papersplease_storefront), [GOG](http://www.gog.com/gamecard/papers_please). I hope is that this little project does not cross the line from homage into infringement.
