# Load libraries 
# pip install tskit
# pip install arg_needle
import tskit
import arg_needle_lib

# Load arg file
argn = arg_needle_lib.deserialize_arg("/mnt/project/data/ARGs/arg_needle_example/example.argn")

# Convert to tskit format
arg_tree = arg_needle_lib.arg_to_tskit(arg = argn)

# Plot a larger tree including all generations

# 'wide_fmt' defines the size of the plot (width, height) in pixels
wide_fmt = (20000, 300) 

# This node label style reduces font size for node labels and rotates the leaf labels for better overall visibility
node_label_style = (
    ".node > .lab {font-size: 50%}"  # Reduce font size 
    ".leaf > .lab {text-anchor: start; transform: rotate(90deg) translate(8px)}"
)

# Plot first tree with draw_svg
arg_tree.first().draw_svg(
    path="tskit_tree_example_array_plot.svg",
    size=wide_fmt,
    time_scale="rank",
    y_gridlines=True,
    y_axis=True,
    y_ticks=[1, 50, 100, 1000],
    style=node_label_style,
)
