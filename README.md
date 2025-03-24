# assembly-press-counter
Press counter in Assembly Code.

# Device Functionality

The device is used to count the presses of individual buttons placed on the board. Upon starting, a dash will appear on all displays. This state indicates that the device is ready for button presses. Created in **CPUEmul_1.2.8.jar**.

## How It Works

- After pressing any button on the board labeled `01234567CDEF`, the corresponding symbol will appear on the **first display**, along with the number of presses for that button.
- The **second display** will show a dash, separating the symbol identifier from the count of presses.
- The **third** and **fourth displays** will show the number of presses for the corresponding button.
- The values will remain on the displays until another button is pressed.

## Special Buttons
In addition to the regular buttons for counting presses, the board also has special buttons that perform specific functions:

- The **SC** button displays the total number of presses for the numbers `0` to `7`.
- The **SP** button displays the total number of presses for the letters `CDEF`.
- The **RESET** button resets the count of presses for all recorded digits and characters.
- The **END** button ends the program.

