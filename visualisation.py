# Load libraries 
# pip install tskit
# pip install arg_needle
import tskit
import arg_needle_lib

# Load arg file
argn = arg_needle_lib.deserialize_arg("/mnt/project/data/ARGs/arg_needle_example/example.argn")

# Convert to tskit format
arg_tree = arg_needle_lib.arg_to_tskit(arg = argn)


