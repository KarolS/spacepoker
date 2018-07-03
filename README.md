# Space Poker

Game released for the 2018 Reset64 4KB 'Craptastic' Game Competition.

![](./src/shot1.png) ![](./src/shot2.png)

## Download

[D64 image](./src/spacepoker.d64)

[Get all the games from the compo](https://reset64-magazine.itch.io/2018-reset64-4kb-craptastic-game-compo)

## Building

You will need  Millfork compiler, version at least 0.3.0:

    java -jar millfork.jar -I PATH_TO_MILLFORK/include -O4 --inline --ipo -t c64 -o cgomc main.mfk