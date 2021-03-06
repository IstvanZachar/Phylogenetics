(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
(* :Title: Phylogenetic functions *)
(* :Context: Phylogenetics` *)
(* :Author: Istv\[AAcute]n Zachar *)
(* :Email: istvan.zachar80@gmail.com *)
(* :Summary: Parsing, converting, displaying and managing phylogenetic tree structures. *)
(* :Copyright: Copyright 2016-2017, Istv\[AAcute]n Zachar *)
(* :Package Version: 1.1 *)
(* :Mathematica Version: 11.0.0.0 *)
(* :Sources: *)
(* :Keywords: *)
(*     phylogeny, cladogram, dendrogram, tree, polytomy *)



(* ::Input::Initialization:: *)
BeginPackage["Phylogenetics`"];


Tree::usage="Tree[\[Ellipsis]] is an inert wrapper of a hierarchical, phylogenetic tree specification. Built-in Graph functions that work on Tree objects are: VertexQ, EdgeList, VertexList, TopologicalSort.";

TreeQ::usage="TreeQ[\!\(\*
StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] returns True if expression expr is a tree object with head Tree.";
NodeQ::usage="NodeQ[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns True if \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) is a valid node vertex within \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\".\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\" \",\nFontSlant->\"Italic\"]\)NodeQ[\!\(\*
StyleBox[\"assoc\",\nFontSlant->\"Italic\"]\)] returns True if association \!\(\*
StyleBox[\"assoc\",\nFontSlant->\"Italic\"]\) represents an internal node vertex.";
LeafQ::usage="LeafQ[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns True if \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) is a valid leaf vertex within \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\".\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\" \",\nFontSlant->\"Italic\"]\)LeafQ[\!\(\*
StyleBox[\"assoc\",\nFontSlant->\"Italic\"]\)] returns True if association \!\(\*
StyleBox[\"assoc\",\nFontSlant->\"Italic\"]\) represents a leaf node vertex.";
UniqueVerticesQ::usage="UniqueVerticesQ[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns True if the \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) has a uniquely named set of vertices and False otherwise.";
BinaryTreeQ::usage="BinaryTreeQ[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns True if all branches of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) split exactly to two, False otherwise.";

DistanceIndex::usage="DistanceIndex[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the absolute distance \!\(\*
StyleBox[SubscriptBox[\"d\", \"i\"],\nFontSlant->\"Italic\"]\) of each vertex \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) from the implicit root at 0 distance as <|\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"d\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"d\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]|>.";
DescendantIndex::usage="DescendantIndex[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the list of all vertices \!\(\*
StyleBox[SubscriptBox[\"s\", \"i\"],\nFontSlant->\"Italic\"]\) below each vertex \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) as <|\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"s\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"s\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]|>.";
AncestorIndex::usage="AncestorIndex[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the list of all vertices \!\(\*
StyleBox[SubscriptBox[\"a\", \"i\"],\nFontSlant->\"Italic\"]\) being ancestral to each vertex \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) as <|\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"a\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"a\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]|>.";
ChildIndex::usage="ChildIndex[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the list of immediate vertices \!\(\*
StyleBox[SubscriptBox[\"c\", \"i\"],\nFontSlant->\"Italic\"]\) below each vertex \!\(\*
StyleBox[SubscriptBox[\"v\", 
StyleBox[\"i\",\nFontSlant->\"Italic\"]],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) as <|\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"c\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"c\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]|>.";
BranchLengthIndex::usage="BranchLengthIndex[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the relative distance \!\(\*
StyleBox[SubscriptBox[\"r\", \"i\"],\nFontSlant->\"Italic\"]\) of each vertex \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) measured from its parent vertex as <|\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"r\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\) \[Rule] \!\(\*SubscriptBox[
StyleBox[\"r\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]|>.";

FullVertexList::usage="FullVertexList[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns a list of all vertices in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) in their full Association form.";
NodeList::usage="NodeList[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the list of internodal vertices of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\).";
LeafList::usage="LeafList[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the list of leaf vertices of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\).";
TreeRoot::usage="TreeRoot[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the first explicit vertex in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). The root can have a distance defined from an implicit node not specified.";
TreeTop::usage="TreeTop[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns a list of vertices in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) that are farthest away from the root in absolute distance.";

Subtree::usage="Subtree[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns the subtree in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) rooted at vertex \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\). If \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) is a leaf vertex, it is returned as Tree[<|\"Name\" \[Rule] \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\), \[Ellipsis]|>, {}]. If \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) is not a vertex of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), Missing[\"NotFound\"] is returned.";
Supertree::usage="Supertree[tree, {\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]}] returns the smallest subtree in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) that contains all vertices \!\(\*
StyleBox[SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \"i\"],\nFontSlant->\"Italic\"]\). If the second argument is a single leaf, it is returned as Tree[<|\"Name\" \[Rule] \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\), \[Ellipsis]|>, {}]. If \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) is not a vertex of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), Missing[\"NotFound\"] is returned.";

BranchLength::usage="BranchLength[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns the branch length of vertex \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). BranchLength[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns the branch lengths of all vertices in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). BranchLength has attribute Listable.";
TreeDistance::usage="TreeDistance[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\)] or TreeDistance[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), {\!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\"}\",\nFontSlant->\"Italic\"]\)] returns the absolute distance between vertices \!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\) and \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), regardless of the direction of intermediate edges. TreeDistance[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns the absolute distance of vertex \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) from the root.";
TreeDistanceMatrix::usage="TreeDistanceMatrix[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\",\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\" \",\nFontSlant->\"Italic\"]\){\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]}] returns the absolute distances between pairs of vertices \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), regardless of the direction of intermediate edges. TreeDistanceMatrix[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns absolute distances of all vertex pairs in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\).";
TreePath::usage="TreePath[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\)] or TreePath[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), {\!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\"}\",\nFontSlant->\"Italic\"]\)] returns the list of edges between vertices \!\(\*
StyleBox[\"a\",\nFontSlant->\"Italic\"]\) and \!\(\*
StyleBox[\"b\",\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), regardless of the direction of intermediate edges. TreePath[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns the path from vertex \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) to the root.";
CommonAncestor::usage="CommonAncestor[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), {\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]}] returns the closest common ancestor vertex of all vertices \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) within \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). CommonAncestor[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\).";
DivergenceTime::usage="DivergenceTime[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), {\!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(1\)]\), \!\(\*SubscriptBox[
StyleBox[\"v\",\nFontSlant->\"Italic\"], \(2\)]\), \[Ellipsis]}] returns the absolute distance of the root node of the smallest supertree consisting all vertices \!\(\*
StyleBox[SubscriptBox[\"v\", \"i\"],\nFontSlant->\"Italic\"]\) from the root of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). DivergenceTime[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\)] returns the distance of vertex \!\(\*
StyleBox[\"v\",\nFontSlant->\"Italic\"]\) from the root of \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\).";


Cladogram::usage="Cladogram[tree] returns a cladogram graph of the Tree object \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). Cladogram[\!\(\*
StyleBox[\"graph\",\nFontSlant->\"Italic\"]\)] returns a cladogram of \!\(\*
StyleBox[\"graph\",\nFontSlant->\"Italic\"]\). Cladogram lays out vertices to appropriately show vertex distances and edge lengths (also stores them as VertexWeight and EdgeWeight, respectively). Cladogram accepts the same options as Graph, except GraphLayout, plus Orientation and LayerSizeFunction.";


Begin["`Private`"];


(* ::Input::Initialization:: *)
TreeQ[_Tree]:=True;
TreeQ[_]:=False;

UniqueVerticesQ[tree_Tree]:=(DeleteDuplicates@#===#)&@VertexList@tree;

Tree/:VertexQ[tree_Tree,node_]:=MemberQ[VertexList@tree,node]
NodeQ[node_Association]:=node@"Type"===Node;
NodeQ[_]:=False;
NodeQ[tree_Tree,node_]:=MemberQ[NodeList@tree,node];
LeafQ[node_Association]:=node@"Type"===Leaf;
LeafQ[_]:=False;
LeafQ[tree_Tree,node_]:=MemberQ[LeafList@tree,node];

BinaryTreeQ[tree_Tree]:=Union@Cases[tree,Tree[_,c_]:>Length@c,{0,\[Infinity]}]==={2};



(* ::Input::Initialization:: *)
distance[n_Association,d_:0]:=(n@"Name"->(d+n@"BranchLength"));
distance[Tree[n_,c_],d_:0]:=Flatten@{distance[n,d],distance[#,d+n@"BranchLength"]&/@c};
DistanceIndex[tree_Tree]:=Association@@distance@tree;

subnode[n_Association]:=n@"Name"->{};
subnode[Tree[n_,c_]]:=(n@"Name"->subnode/@c);
DescendantIndex[tree_Tree]:=Association@@Reverse@Cases[subnode@tree,(a_->b_):>(a->Flatten@(b/.Rule->List)),{0,\[Infinity]}];

AncestorIndex[tree_Tree]:=Module[{leafPaths=TreePath[tree,#]&/@LeafList@tree},(* NOTE: Only calculates longest paths as `leafPaths` as path finding is costly. All the rest can be deduced from longest paths. *)
Association@@Join[{TreeRoot@tree->{}},
(#[[-1,-1]]->DeleteDuplicates@Most@Flatten[List@@@#])&/@(Reverse/@DeleteDuplicates@Flatten[(NestList[Rest,#,Length@#-1]&/@leafPaths),1])]];

ChildIndex[tree_Tree]:=Association@@Reverse@Cases[subnode@tree,(a_->b_):>(a->(First/@b)),{0,\[Infinity]}];

BranchLengthIndex[tree_Tree]:=AssociationThread@@(Lookup[FullVertexList@tree,{"Name","BranchLength"}]\[Transpose]);


(* ::Input::Initialization:: *)
FullVertexList[tree_Tree,lvl_:{0,\[Infinity]}]:=Cases[tree,_Association,lvl];

NodeList[tree_Tree,lvl_:{0,\[Infinity]}]:=Cases[tree,n_?NodeQ:>n@"Name",lvl]; 
LeafList[tree_Tree,lvl_:{0,\[Infinity]}]:=Cases[tree,n_?LeafQ:>n@"Name",lvl];
Tree/:EdgeList[tree_Tree]:=Flatten[Thread/@Normal@ChildIndex@tree];
Tree/:VertexList[tree_Tree,lvl_:{0,\[Infinity]}]:=Lookup[FullVertexList[tree,lvl],"Name"];
Tree/:TopologicalSort[tree_Tree]:=VertexList@tree;
TreeRoot[tree_Tree]:=(First@tree)@"Name";
TreeTop[tree_Tree]:=First/@MaximalBy[Normal@DistanceIndex@tree,Last];

Subtree[tree_Tree]:=tree;
Subtree[tree_Tree,node_,lvl_:{0,\[Infinity]}]:=Module[{pos,n},
pos=FirstPosition[tree,_Association?(#Name===node&),Missing["NotFound"],lvl];
Which[
MissingQ@pos,pos,
pos==={1},tree,
n=Extract[tree,pos];LeafQ@n,Tree[n,{}],
True,Extract[tree,Drop[pos,-1]]]
];

Supertree[tree_Tree,nodes_List]:=Module[{path=Union@(Sort/@Partition[Union@nodes,2,1,{-1,-1},{}]),all,root},
all=Union@Flatten@(List@@@Flatten[TreePath[tree,#]&/@path]);
root=FirstCase[TopologicalSort@tree,Alternatives@@all];
Subtree[tree,root]
];
Supertree[tree_Tree,node_]:=Supertree[tree,{node}];


(* ::Input::Initialization:: *)
Attributes[BranchLength]={Listable};
BranchLength[tree_Tree]:=Cases[tree,n_Association:>n@"BranchLength",{0,\[Infinity]}];
BranchLength[tree_Tree,node_]:=(BranchLengthIndex@tree)@node;

TreePath[tree_Tree,{a_,b_}]:=TreePath[tree,a,b];
TreePath[tree_Tree,{a_}]:=TreePath[tree,a,a];
TreePath[tree_Tree,a_]:=If[VertexQ[tree,a],TreePath[tree,a,TreeRoot@tree],{}];
TreePath[tree_Tree,a_,a_]:=If[VertexQ[tree,a],a,{}];
TreePath[tree_Tree,a_,b_]:=If[VertexQ[tree,a]&&VertexQ[tree,b],Module[{g=TreeToGraph[tree,DirectedEdges->False],pos},
pos=First/@PositionIndex@TopologicalSort@tree;
Sort[#,pos@#1<pos@#2&]&/@(Rule@@@Partition[FindShortestPath[g,a,b],2,1])
],{}];

TreeDistance[tree_Tree,{a_,b_}]:=TreeDistance[tree,a,b];
TreeDistance[tree_Tree,{a_}]:=TreeDistance[tree,a,a];
TreeDistance[tree_Tree,a_]:=If[VertexQ[tree,a],TreeDistance[tree,a,TreeRoot@tree],\[Infinity]];
TreeDistance[tree_Tree,a_,a_]:=If[VertexQ[tree,a],0,\[Infinity]];
TreeDistance[tree_Tree,a_,b_]:=If[VertexQ[tree,a]&&VertexQ[tree,b],Total[(Last/@TreePath[tree,a,b])/.BranchLengthIndex@tree],\[Infinity]];

TreeDistanceMatrix[tree_Tree]:=TreeDistanceMatrix[tree,VertexList@tree];
TreeDistanceMatrix[tree_Tree,v_List]:=Module[{p,m},
p=First/@PositionIndex@v;
m=Outer[If[p@#1>p@#2,0,TreeDistance[tree,#1,#2]]&,v,v];
m+m\[Transpose]];

CommonAncestor[tree_Tree,nodes_List]:=TreeRoot@Supertree[tree,Union@nodes];
CommonAncestor[tree_Tree,node_]:=node;

DivergenceTime[tree_Tree,nodes_List]:=(DistanceIndex@tree)@CommonAncestor[tree,Union@nodes];
DivergenceTime[tree_Tree,node_]:=(DistanceIndex@tree)@node;


(* ::Input::Initialization:: *)
Options@Cladogram=DeleteCases[mergeRules[Options@Graph,{
Orientation->Left,
LayerSizeFunction->(1/2#&),
EdgeLabels->None,
FrameTicks->All,
VertexSize->{"Scaled",.01}
}],_[GraphLayout,_]];
Cladogram[{},___]:={};
Cladogram[list_List,opts:OptionsPattern[]]:=Cladogram[#,opts]&/@list;
Cladogram[gr_Graph?TreeGraphQ,opts:OptionsPattern[]]:=Module[
{g=If[DirectedGraphQ@gr,gr,DirectedGraph[gr,"Acyclic",FilterRules[{opts},Options@DirectedGraph]]],n,e,x,y,el,vl,coord,size,dir,leafs,collapse,ew},
{size,dir,el}=OptionValue@{LayerSizeFunction,Orientation,EdgeLabels};
{n,x,e,ew}={VertexList@g,PropertyValue[g,VertexWeight],EdgeList@g,PropertyValue[g,EdgeWeight]};
x=If[x===Automatic,If[ew===Automatic,GraphDistance[g,First@TopologicalSort@g],Prepend[n/.Thread[(Last/@e)->ew],0]],x];
ew=If[ew===Automatic,-(Subtract@@@(e/.Thread[n->x])),ew];

leafs=DeleteCases[Reverse@TopologicalSort@g,Alternatives@@(First/@e)];
y=Thread[leafs->(1/(2 size@1)) If[Length@leafs<2,{1},Subdivide[0,(Max@x-Min@x),Length@leafs-1]]];
collapse[n_]:=Flatten@If[MemberQ[leafs,n],{n/.y},collapse/@Cases[e,n\[DirectedEdge]to_:>to]];
y=Mean@*MinMax@*collapse/@n;
coord=Switch[dir,
Top,Reverse/@Transpose@{-x,y},
Bottom,Reverse/@Transpose@{x,y},
Left,Transpose@{x,y},
Right,Transpose@{-x,y}];

vl=PropertyValue[g,VertexLabels];
vl=Switch[vl,
{"Name"},Thread[n->n],
{"VertexWeight"},Thread[n->x],
{"Index"},Thread[n->Range@Length@n],
None|Automatic,{},
{Repeated[_Rule]},vl/.Placed[a_,___]:>a,
{_String, Repeated[_Rule]},vl[[2;;]]/.Placed[a_,___]:>a,
{_},Thread[n->First@vl]
];
vl=Switch[Last@#,None,Nothing,_[_,_Placed],#,_,First@#->Placed[Last@#,dir]]&/@vl;

Graph[n,e,
FilterRules[mergeRules[Options@Cladogram,{
VertexWeight->x,
VertexLabels->DeleteCases[vl,Nothing],(* NOTE: For backwards compatibility with v10, when Nothing is not defined. *)
EdgeWeight->ew,
EdgeLabels->Switch[el,Automatic,Placed["EdgeWeight",{3/5,{0,0}}],_,el],
EdgeShapeFunction->(BSplineCurve[{First@#1,Total[#1[[Switch[dir,Left|Right,{1,-1},_,{-1,1}]]] {{1,0},{0,1}}],Last@#1},SplineWeights->{1,1000,1}]&),(* NOTE: From Vitaliy Kaurov: http://community.wolfram.com/groups/-/m/t/241376 *)
VertexCoordinates->coord,
GraphHighlight->Flatten@{OptionValue@GraphHighlight/.t_Tree:>Flatten@{EdgeList@t,VertexList@t}}
},
DeleteCases[FilterRules[{opts},Options@Cladogram],_[GraphHighlight|EdgeLabels,_]]
],Options@Graph]]
];
Cladogram[tree_Tree,opts:OptionsPattern[]]:=Cladogram[TreeToGraph@tree,opts];


(* ::Input::Initialization:: *)
format[n_Association]:=Tooltip[Framed[n@"Name",FrameMargins->2,RoundingRadius->1,Background->GrayLevel[95/100],BaseStyle->Directive[GrayLevel[3/10]],FrameStyle->Directive[AbsoluteThickness@1,GrayLevel[7/10]]],n];
format[x_]:=x;
MakeBoxes[tree_Tree,fmt:(StandardForm|TraditionalForm)]:=With[{boxes=RowBox[{"Tree","[",ToBoxes[format@First@tree,fmt],",",ToBoxes[format/@Last@tree,fmt],"]"}]},
InterpretationBox[boxes,tree]];


(* ::Input::Initialization:: *)
End[];

Protect[Tree];
Protect[TreeQ,NodeQ,UniqueVerticesQ,BinaryTreeQ];
Protect[DistanceIndex,DescendantIndex,AncestorIndex,ChildIndex,BranchLengthIndex];
Protect[FullVertexList,NodeList,LeafList,TreeRoot,TreeTop];
Protect[Subtree,Supertree];
Protect[BranchLength,TreeDistance,TreeDistanceMatrix,TreePath];
Protect[CommonAncestor,DivergenceTime];
Protect[Cladogram];

EndPackage[];
