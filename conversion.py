import pandas as pd
import sys

# Ensure correct number of arguments
if len(sys.argv) != 3:
    print("Usage: python3 conversion.py <input_edges_file> <output_mcl_file>")
    sys.exit(1)

# Read input arguments
input_file = sys.argv[1]
output_file = sys.argv[2]

# Load the edges file
edges = pd.read_csv(input_file)

# Rename columns to standard names (optional, for consistency)
edges.rename(columns={'id1': 'source', 'id2': 'target'}, inplace=True)

# Assign default weight if not provided
edges['weight'] = 1.0

# Save in MCL-compatible format
edges[['source', 'target', 'weight']].to_csv(
    output_file, 
    sep=' ',  # Use space as delimiter
    header=False,  # No header for MCL
    index=False  # No row indices
)

print(f"Graph saved to {output_file} in MCL format.")