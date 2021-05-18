This package is implementing the method in International Conference on Neural Computing for Advanced Applications 2021 paper: Smoothed Multi-View Subspace Clustering. Please contact [Zkang@uestc.edu.cn](mailto:Zkang@uestc.edu.cn) if you have any questions.

# A Brief Introduction to This Code

This package contains five matlab files and two data directories.

runlmv.m : If you just simply want to run this algorithm and see its performance, then visit this file. You can run this file after changing the dataset name(or parameters、filtering strategy) in the code. Its performance will be recorded automatically. It is advisable to read the remarks in this file before you run it in matlab.

lmv.m : The code is based on LMVSC. If you are seeking to learn more about the details of the mechanism of LMVSC and its programming implementation, see this file.

ClusteringMeasure : This function measures the performance of LMVSC with 3 indicators--Accuracy, NMI and Purity.

litekmeans : Perform K-Means clustering.

mySVD : Perform singular value decomposition.

dataset(dir) : Directory for datasets.

graph(dir): Directory for graphs datasets.





