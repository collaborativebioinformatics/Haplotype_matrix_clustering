# Load libraries 
# pip install tskit
# pip install arg_needle
import tskit
import arg_needle_lib

# Load arg file
argn = arg_needle_lib.deserialize_arg("/mnt/project/data/ARGs/arg_needle_example/example.argn")

# Convert to tskit format
arg_tree = arg_needle_lib.arg_to_tskit(arg = argn)

# A larger tree, on a log timescale
wide_fmt = (7000, 250)
node_label_style = (
    ".node > .lab {font-size: 80%}"
    ".leaf > .lab {text-anchor: start; transform: rotate(90deg) translate(6px)}"
)
arg_tree.first().draw_svg(
    size=wide_fmt,
    time_scale="log_time",
    y_gridlines=True,
    y_axis=True,
    y_ticks=[1, 10, 100, 1000],
    style=node_label_style,
)
