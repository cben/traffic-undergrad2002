set terminal postscript color
set data style lines
set output 'react_0.05-longest-wait.ps'
set title 'react_0.05-longest-wait'
plot 'react_0.05-longest_5x5-wait.dat', 'react_0.05-longest_15x15-wait.dat', 'react_0.05-longest_10x10-wait.dat'
