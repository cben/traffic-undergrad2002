set terminal postscript color
set data style lines
set output 'react_0.05-rand-car.ps'
set title 'react_0.05-rand-car'
plot 'react_0.05-rand_5x5-car.dat', 'react_0.05-rand_15x15-car.dat', 'react_0.05-rand_10x10-car.dat'
