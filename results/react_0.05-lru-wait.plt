set terminal postscript color
set data style lines
set output 'react_0.05-lru-wait.ps'
set title 'react_0.05-lru-wait'
plot 'react_0.05-lru_5x5-wait.dat', 'react_0.05-lru_15x15-wait.dat', 'react_0.05-lru_10x10-wait.dat'
