set terminal postscript color
set data style lines
set output 'react_0.20-inorder-wait.ps'
set title 'react_0.20-inorder-wait'
plot 'react_0.20-inorder_5x5-wait.dat', 'react_0.20-inorder_15x15-wait.dat', 'react_0.20-inorder_10x10-wait.dat'
