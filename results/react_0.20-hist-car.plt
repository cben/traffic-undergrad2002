set terminal postscript color
set data style lines
set output 'react_0.20-hist-car.ps'
set title 'react_0.20-hist-car'
plot 'react_0.20-hist_5x5-car.dat', 'react_0.20-hist_15x15-car.dat', 'react_0.20-hist_10x10-car.dat'
