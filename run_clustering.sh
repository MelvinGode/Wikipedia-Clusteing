#!/bin/bash

# Define file paths
EDGES_FILE="/Users/Andrej/Documents/MVA/PGM/Wikipedia-Clustering/data/small_graphs/crocodile/musae_crocodile_edges.csv"
CONVERSION_SCRIPT="/Users/Andrej/Documents/MVA/PGM/Wikipedia-Clustering/conversion.py"
MCL_INPUT="/Users/Andrej/Documents/MVA/PGM/Wikipedia-Clustering/crocodile_graph.txt"
MCL_OUTPUT="crocodile_clusters.txt"

# Step 1: Convert input files to MCL-compatible format
echo "Converting input files to MCL-compatible format..."
python3 "$CONVERSION_SCRIPT" "$EDGES_FILE" "$MCL_INPUT"
if [ $? -ne 0 ]; then
  echo "Error: Conversion script failed."
  exit 1
fi
echo "Conversion complete. Output saved to $MCL_INPUT."

# Step 2: Run MCL clustering
export PATH=$PATH:/Users/Andrej/local/bin
echo "Running MCL clustering on $MCL_INPUT..."
cd /Users/Andrej/Documents/MVA/PGM/Wikipedia-Clustering/installmcl
pwd

which mcl
mcl "$MCL_INPUT" --abc -I 1.8 -o "$MCL_OUTPUT"
if [ $? -ne 0 ]; then
  echo "Error: MCL clustering failed."
  exit 1
fi
echo "Clustering complete. Output saved to $MCL_OUTPUT."

# Step 3: Summary of clusters
echo "Cluster summary:"
NUM_CLUSTERS=$(wc -l < "$MCL_OUTPUT")
echo "Total clusters: $NUM_CLUSTERS"
awk '{print NF}' crocodile_clusters.txt | sort -n | uniq -c