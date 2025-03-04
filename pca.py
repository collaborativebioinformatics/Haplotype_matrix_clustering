!python -m pip install --upgrade pip -q
!pip install tskit -q
!pip install arg_needle -q
!pip install scikit-learn -q

import arg_needle_lib as anl
from sklearn.decomposition import PCA
import numpy as np
import matplotlib.pyplot as plt

argn = anl.deserialize_arg("/mnt/project/data/ARGs/arg_needle_example/example.argn")
mutation_rate = 1e-7
random_seed = 20250304
argn.populate_children_and_roots()
anl.generate_mutations(argn, mu=mutation_rate, random_seed=random_seed)
grm = anl.compute_grm(argn, alpha=0, diploid=True)

pca = PCA(n_components=2)
principal_components = pca.fit_transform(grm)
plt.figure(figsize=(8, 6))
plt.scatter(principal_components[:, 0], principal_components[:, 1], alpha=0.7)
plt.title("PCA of ARG Data (GRM)")
plt.xlabel("Principal Component 1")
plt.ylabel("Principal Component 2")
plt.grid()
plt.show()
