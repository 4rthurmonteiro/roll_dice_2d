## 1.0.0

* Initial release of the `roll_dice_2d` package.
* **Features**:
    * Displays an animated 2D dice.
    * Customizable dice color (`DiceColor.red` or `DiceColor.white`).
    * Configurable number of animated rolls (`rollingTimes`) and animation speed (`speed`).
    * `onRoll` callback providing the final dice value (1-6).
    * Includes bundled dice images for red and white dice.
    * Deterministic roll sequence due to a fixed random seed, useful for testing.