set terminal postscript color
set data style lines
set output 'react_0.05-inorder-dev.ps'
set title 'react_0.05-inorder-dev'
plot 'react_0.05-inorder_5x5-dev.dat', 'react_0.05-inorder_15x15-dev.dat', 'react_0.05-inorder_10x10-dev.dat'
