set terminal postscript color
set data style lines
set output 'react_0.05-hold_inorder-wait.ps'
set title 'react_0.05-hold_inorder-wait'
plot 'react_0.05-hold_inorder_5x5-wait.dat', 'react_0.05-hold_inorder_15x15-wait.dat', 'react_0.05-hold_inorder_10x10-wait.dat'
