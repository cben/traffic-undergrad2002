set terminal postscript color
set data style lines
set output 'react_0.05-lru-car.ps'
set title 'react_0.05-lru-car'
plot 'react_0.05-lru_5x5-car.dat', 'react_0.05-lru_15x15-car.dat', 'react_0.05-lru_10x10-car.dat'
