set terminal postscript color
set data style lines
set output 'react_0.05-hold_longest-car.ps'
set title 'react_0.05-hold_longest-car'
plot 'react_0.05-hold_longest_5x5-car.dat', 'react_0.05-hold_longest_15x15-car.dat', 'react_0.05-hold_longest_10x10-car.dat'
