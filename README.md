# **K-means Clustering in MATLAB**  

A MATLAB implementation of the **K-means clustering algorithm** with optional **animated visualization** of the clustering process.  

---

## **📌 Features**  
- **Customizable K-means clustering** for any input vector.  
- **Random or fixed initial centroids** (configurable).  
- **Step-by-step animation** to visualize how clusters evolve.  
- **Dynamic centroid updates** until convergence.  
- **Performance tracking** (number of iterations to convergence).  

---

## **🚀 How to Use**  

### **Basic Usage**  
```matlab
% Generate sample data (2D points)
data = rand(2, 100);  
groups = K_means(data, data, 3, true, true);  
```

### **Input Parameters**  
| Parameter       | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `Vector`       | Input data (each column is a data point).                                   |
| `Vector_2`     | Secondary vector (used for visualization, often same as `Vector`).         |
| `k`            | Number of clusters (default: `3`).                                         |
| `is_random` | If `true`, initial centroids are random; if `false`, first `k` points are used. |
| `Animated`      | If `true`, shows an animated step-by-step clustering process.              |

### **Output**  
- `Cluster`: A vector containing the cluster assignment for each data point.  

---

## **📊 Example: Animated Clustering**  
```matlab
% Generate synthetic data  
X = [randn(2,50)*0.5 + [1;1], randn(2,50)*0.5 + [-1;-1], randn(2,50)*0.5 + [1;-1]];  

% Run K-means with animation  
cluster_labels = K_means(X, X, 3, true, true);  
```  
This will display an interactive visualization of the clustering process.  

---

## **📝 Notes**  
- The algorithm stops when cluster assignments no longer change (convergence).  
- For large datasets, disable animation (`Animated = false`) for faster execution.  
- Works best with **2D/3D data** for visualization, but can handle higher dimensions.  

---

## **📜 License**  
This project is open-source under the **MIT License**.  

---

**🎯 Contributions welcome!** Feel free to fork, improve, or report issues.  

--- 
