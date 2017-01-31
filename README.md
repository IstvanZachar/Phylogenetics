# Phylogenetics

Phylogenetics with the Wolfram Language.

Related post at Mathematica.StackExchange: How to work with phylogenetic trees? http://mathematica.stackexchange.com/q/126496/89

## Description

The ``Phylogenetics` `` package can:
 - parse a Newick tree string to a *Mathematica*-usable `Tree` object and write a `Tree` object to a Newick string;
 - parse a `Cluster` object of the ``HierarchicalClustering` `` package to a `Tree` and convert a `Tree` to `Cluster` representation;
 - test properties of `Tree` objects;
 - extract vertices, edges, internal nodes, leafs, sub- and supertrees of `Tree` objects;
 - directly calculate various properties of `Tree` objects like paths and distances between vertices;
 - convert a `Tree` object to `Graph`, and a tree `Graph` to `Tree`; any tree graph (`TreeGraph`, `ClusteringTree`, etc.) for which `TreeGraphQ` returns `True` can be converted to `Tree`;
 - convert a `Tree` object or a `Graph` tree to `Cladogram` graph,
 - provide example trees in Newick and `Cluster` format.

## Version history
- 2016 09 08: Package initialized.
- 2016 09 16: PUBLISHED: Version 1.0.0.
- 2016 01 31: PUBLISHED: Version 1.1.0.
    - ADDED: `CommonAncestor`, `DivergenceTime`, `AncestorIndex`, `TreeDistanceMatrix`, `TreeTop`, `$PhylogeneticsVersionNumber`.
    - FIXED: Usage message corrections.
    - FEATURE: Straight `Cladogram` edges, branching according to angle.
    - MODIFIED: `LeafQ` and `NodeQ` now can be applied to a single argument representing a node association.
    - RENAMED: `SubnodeIndex` to `DescendantIndex`.
    - MODIFIED: Code was made compatible down to *Mathematica* 10.0. No compatibility before that due to heavy usage of associations.

## Sources

- The Newick Standard: http://evolution.genetics.washington.edu/phylip/newicktree.html
- Wikipedia: Newick format: https://en.wikipedia.org/wiki/Newick_format
- Newick tree formats: http://marvin.cs.uidaho.edu/Teaching/CS515/newickFormat.html
- An online Newick tree visualizer: http://etetoolkit.org/treeview/
- Parfrey, Lahr, Knoll & Katz 2011: 
    Estimating the timing of early eukaryotic diversification with multigene molecular clocks. PNAS 108, 13624 - 13629. doi: http://dx.doi.org/10.1073/pnas.1110633108. Supplementary Information.



By István Zachar
2016-2017


