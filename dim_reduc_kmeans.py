import numpy as np

class Haplotype: 
    def __init__(self, haps_file):
        self.data = self._load_haps_file(haps_file)
        self.scaled = None
        self.reduced = None
    def _load_haps_file(self, haps_file):
        try: 
            try:
                with open(haps_file, 'r') as f:
                    first_line = f.readline().strip().split()
                    total_columns = len(first_line)
                
                usecols = list(range(4, total_columns))
                
                data = np.loadtxt(haps_file, delimiter="\t", usecols=usecols, dtype=float)
            except Exception as e: 
                try:
                    with open(haps_file, 'r') as f:
                        first_line = f.readline().strip().split()
                        total_columns = len(first_line)
                    
                    usecols = list(range(5, total_columns))
                    data = np.loadtxt(haps_file, delimiter=None, usecols=usecols, dtype=float)
                except Exception as e:
                    print(f"Error loading file: {e}")
                    raise
            return data
        except Exception as e:
            print(f"Critical error in file loading: {e}")
            raise
        
        
    def process_data(self, normalize = True):
        data = self.haps_data.copy().astype(np.float64)
        std_dev = np.std(data, axis=0)
        mask = std_dev > 0
        data = data[:, mask]
        if normalize:
            self.scaled_data = (data - np.mean(data, axis=0)) / np.std(data, axis=0)
        else:
            self.scaled_data = data
        
        return self.scaled_data
    
    def PCA_reduc(self, n_components = 2):
        if self.scaled_data == None:
            self.process_data()
        covar = np.cov(self.scaled_data.T)
        eigenvalues, eigenvectors = np.linalg.eig(cov_matrix)
        idx = eigenvalues.argsort()[::-1]
        eigenvalues = eigenvalues[idx]
        eigenvectors = eigenvectors[:, idx]
        n_comp = min(n_components, eigenvectors.shape[1])
        top_eigenvectors = eigenvectors[:, :n_comp]
        self.reduced_data = np.dot(self.scaled_data, top_eigenvectors)
        return self.reduced_data


    def kmeans_clustering(self, n_clusters=3, max_iter=100):
        if self.reduced_data is None:
            self.pca_reduction()
        
        n_clusters = min(n_clusters, self.reduced_data.shape[0])
        
        np.random.seed(42)
        centroids = self.reduced_data[np.random.choice(self.reduced_data.shape[0], 
                                                       n_clusters, 
                                                       replace=False)]
        
        for _ in range(max_iter):
            distances = np.sqrt(((self.reduced_data[:, np.newaxis] - centroids) ** 2).sum(axis=2))
            labels = np.argmin(distances, axis=1)
            
            new_centroids = np.array([
                self.reduced_data[labels == k].mean(axis=0) 
                for k in range(n_clusters)
            ])
            
            if np.all(centroids == new_centroids):
                break
            
            centroids = new_centroids
        
        return labels

def main():
    haps_file = "./ALL.chr21.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.haps"
    
    try:
        hap_analysis = Haplotype(haps_file)
        
        hap_analysis.preprocess_data()
        
        reduced_data = hap_analysis.pca_reduction(n_components=2)
        
        cluster_labels = hap_analysis.kmeans_clustering(n_clusters=3)
        
        hap_analysis.save_results(reduced_data, cluster_labels)
        
        print("Done")
    
    except Exception as e:
        print(f"failed: {e}")

if __name__ == "__main__":
    main()
                