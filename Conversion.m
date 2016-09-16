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
(* :Title: Convert phylogenetic trees *)
(* :Context: Phylogenetics` *)
(* :Author: Istv\[AAcute]n Zachar *)
(* :Summary: Parsing and converting phylogenetic trees of various formats. *)
(* :Copyright: Copyright 2016, Istv\[AAcute]n Zachar *)
(* :Package Version: 1.0 *)
(* :Mathematica Version: 11.0.0.0 *)
(* :Sources: *)
(*  - The Newick Standard: http://evolution.genetics.washington.edu/phylip/newicktree.html *)
(*  - Wikipedia:Newick format: https://en.wikipedia.org/wiki/Newick_format *)
(*  - Newick tree formats: http://marvin.cs.uidaho.edu/Teaching/CS515/newickFormat.html *)
(*  - An online Newick tree visualizer: http://etetoolkit.org/treeview/ *)
(* :Keywords: *)
(*     Newick format, hierarchical clustering, cluster, parsing *)

(* :History: *)
(*     2016 09 08 - INITIALIZED: Package initialized. *)
(*     2016 09 16 - PUBLISHED: Package first published. *)



(* ::Input::Initialization:: *)
BeginPackage["Phylogenetics`",{"HierarchicalClustering`"}]; (* USES: HierarchicalClustering`Cluster *)


$TreeVertexProperties::usage="$TreeVertexKeys lists the available keys in a vertex of a Tree object.";

NewickTreeQ::usage="NewickTreeQ[\!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\)] returns true if the string \!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\) is a valid tree specification in the Newick format, i.e. has a balanced set of parenthesis. It is not necessary that the string terminates with a \";\".";
NewickToTree::usage="NewickToTree[\!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\)] returns a Tree representation of the Newick tree string \!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\). Unnamed nodes in \!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\) are assigned a unique integer index. If multiple nodes uses the same label \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\) in \!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\), only one vertex will be named \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\) and the rest recieve unique indices, but all will be labeled \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\). If \!\(\*
StyleBox[\"s\",\nFontSlant->\"Italic\"]\) specifies a series of trees separated by \";\", NewickToTree returns a list of parsed trees. NewickToTree has attribute Listable.";
TreeToNewick::usage="TreeToNewick[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] converts the Tree object \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\) to Newick format, i.e. to a linear string of parenthesis notation. TreeToNewick has attribute Listable.";

Node::usage="Node is an inert wrapper that is used only for parsing a Newick tree.";
Leaf::usage="Leaf is an inert wrapper that is used only for parsing a Newick tree.";


ClusterToTree::usage="ClusterToTree[\!\(\*
StyleBox[\"clus\",\nFontSlant->\"Italic\"]\)] converts the hierarchical clustering object \!\(\*
StyleBox[\"clus\",\nFontSlant->\"Italic\"]\) to a Tree object.";
TreeToCluster::usage="TreeToCluster[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] converts the hierarchical tree object to a cluster object.";


TreeToGraph::usage="TreeToGraph[\!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\)] returns a tree graph of the Tree object \!\(\*
StyleBox[\"tree\",\nFontSlant->\"Italic\"]\). TreeToGraph[\!\(\*
StyleBox[\"graph\",\nFontSlant->\"Italic\"]\)] returns a tree graph of \!\(\*
StyleBox[\"graph\",\nFontSlant->\"Italic\"]\). TreeToGraph lays out the graph with a layered embedding. It does not show vertex distances and edge lengths correctly but stores them as VertexWeight and EdgeWeight.";
GraphToTree::usage="GraphToTree[\!\(\*
StyleBox[\"g\",\nFontSlant->\"Italic\"]\)] returns a Tree object of the tree graph \!\(\*
StyleBox[\"g\",\nFontSlant->\"Italic\"]\), calculating branch lengths from VertexWeight. If VertexWeight is not defined, EdgeWeight is used for branch lengths, to calculate absolute positions, assuming root at 0. If no VertexWeight or EdgeWeight is specified, equidistant neighbouring nodes are assumed.";


General::nobintree="`1` is not a binary tree object.";
General::notree="The string \"`1`\" is not a valid Newick tree specification. A Newick tree has to have a balanced set of parenthesis."; 


Begin["`Private`"];


(* ::Input::Initialization:: *)
$TreeVertexProperties={"Name","Label","BranchLength","Type"};



(* ::Input::Initialization:: *)
NewickTreeQ[s_String]:=StringMatchQ[StringTrim@s,StartOfString~~"("~~___~~")"~~Except@")"...~~EndOfString]&&(StringCount[s,"("]===StringCount[s,")"]);
NewickTreeQ[_]:=False;

processNode["",h_String]:={h<>"[None->1]"};
processNode[str_String,h_String]:=(
If[StringMatchQ[#,"Tree"|"Node"|"Leaf"~~__],#,
First@StringCases[#,n:Except[":"]...~~(":"~~d:NumberString)|"":>h<>"["<>If[n==="","None","\""<>n<>"\""]<>"->"<>(d/.""->"1")<>"]",1]]
)&/@(StringTrim/@StringSplit[str,",",All]);(* NOTE: Split and collect all nodes, even if it is an empty string. *)
processTree[str_String]:=StringReplace[str,"("~~c:Shortest[Except["("|")"]...]~~")"~~p:Except[")"|"("|","|";"]...:>(
"Tree["<>ToString@First@processNode[p,"Node"]<>"~"<>StringReplace[ToString@processNode[c,"Leaf"],","->"~"]<>"]")];
parseTree[str_String]:=StringReplace[FixedPoint[processTree,StringTrim[str,Whitespace|";"]],"~"->","];

Attributes[NewickToTree]={Listable};
NewickToTree[s_String]/;If[NewickTreeQ@s,True,Message[General::notree,s];False]:=Module[{tree,c=1,labels={}},
tree=If[StringMatchQ[StringTrim@s,"*;"~~__],NewickToTree/@StringSplit[s,";"],ToExpression@parseTree@s];
tree/.(n:Node|Leaf)[p_Rule]:>Block[{lbl=If[Head@p===Rule,First@p,p]},
<|
"Name"->If[lbl===None||MemberQ[labels,lbl],c++,AppendTo[labels,lbl];lbl],
"Label"->lbl,
"BranchLength"->If[Head@p===Rule,Last@p,1],
"Type"->(n/.{Leaf->"Leaf",Node->"Node"})
|>
]];

write[n_String]:=n;
write[n_Association]:=(n@"Label"/.None->"")<>If[#==1,"",":"<>ToString@#]&@n@"BranchLength";
Attributes[TreeToNewick]={Listable};
TreeToNewick[tree_Tree]:=Fold[Replace[#1,Tree[p_,s_]:>"("<>StringJoin@Riffle[write/@s,","]<>")"<>write@p,{#2}]&,tree,Range[Depth@tree,0,-1]]<>";"



(* ::Input::Initialization:: *)
ClusterToTree[cl_Cluster]:=Module[{c=1,labels={}},
cl//.Cluster[c1_,c2_,d_,_,_]:>Tree[c++,
#->(d-If[Head@#===Cluster,#[[3]],0])&/@{c1,c2}]//.Rule[Tree[p_,s_],z_]:>Tree[p->z,s]/.Tree[1,s_]:>Tree[1->0,s]//.
Tree[p_->z_,s_]:>Tree[(
<|
"Name"->If[p===None||MemberQ[labels,p],c++,AppendTo[labels,p];p],
"Label"->None,
"Type"->"Node",
"BranchLength"->z
|>
),s]/.Rule[p_,z_]:>(
<|
"Name"->If[p===None||MemberQ[labels,p],c++,AppendTo[labels,p];p],
"Label"->p,
"Type"->"Leaf",
"BranchLength"->z
|>
)];

count[n_Association]:=1;
count[Tree[_,c_]]:=Total[count/@c];
TreeToCluster[tree_Tree]/;If[BinaryTreeQ@tree,True,Message[General::nobintree,Shallow@tree];False]:=Module[
{d=DistanceIndex@tree,max,clusterize},
max=Max@Values@d;
clusterize[Tree[n_,{c1_,c2_}]]:=Cluster@@Flatten@{If[TreeQ@#,clusterize@#,#@"Name"]&/@{c1,c2},max-(n@"Name"/.d),count/@{c1,c2}};
clusterize@tree];


(* ::Input::Initialization:: *)
Options[TreeToGraph]=mergeRules[Options@Graph,{GraphLayout->{"LayeredEmbedding","Orientation"->Left,LayerSizeFunction->(1&)}}];
TreeToGraph[tree_Tree,opts:OptionsPattern[]]:=Module[{nodes=FullVertexList@tree,e=EdgeList@tree,v,vl,bl},
{v,vl,bl}=Transpose@Lookup[nodes,{"Name","Label","BranchLength"}];
(*Print@Column@{bl,((Last/@e)/.Thread[v\[Rule]bl]),Thread[v\[Rule]vl]};*)
Graph[v,e,mergeRules[
GraphLayout->{"LayeredEmbedding", "Orientation"->Left,LayerSizeFunction->(1&),"RootVertex"->TreeRoot@tree},
EdgeWeight->((Last/@e)/.Thread[v->bl]),
VertexWeight->Normal@DistanceIndex@tree,
VertexLabels->Thread[v->vl],
opts]]];
TreeToGraph[spec__,opts:OptionsPattern[]]:=Graph[spec,mergeRules[Options@TreeToGraph,FilterRules[{opts},Options@TreeToGraph]]];

GraphToTree[gr_Graph?TreeGraphQ]:=Module[{g=If[DirectedGraphQ@gr,gr,DirectedGraph[gr,"Acyclic"]],gd,root,n,e,x,ew,bl,parent,rep},
root=First@TopologicalSort@g;
{n,e,x,ew}={VertexList@g,EdgeList@g,PropertyValue[g,VertexWeight],PropertyValue[g,EdgeWeight]};
gd=AssociationThread[n->GraphDistanceMatrix@g];
x=AssociationThread[n->If[x===Automatic,If[ew===Automatic,First@gd,Prepend[n/.Thread[(Last/@e)->ew],0]],x]];
parent=Rule@@@Reverse/@e;
bl=AssociationMap[x@#-x[#/.parent]&,n];(* NOTE: Branch length per vertex. If no parent exists, branch length is taken to be zero. *)
(*Print@Column@{e,x,parent,bl};*)
rep[node_]:=Module[{sub=Pick[n,gd@node,1]},If[sub==={},
<|
"Name"->node,
"Label"->(Switch[#,"Index",VertexIndex[g,node],"Name",node,_,#]&@PropertyValue[{g,node},VertexLabels]),
"BranchLength"->Lookup[bl,node,1],
"Type"->"Leaf"
|>,
Tree[
<|
"Name"->node,
"Label"->(Switch[#,"Index",VertexIndex[g,node],"Name",node,_,#]&@PropertyValue[{g,node},VertexLabels]),
"BranchLength"->Lookup[bl,node,1],
"Type"->"Node"
|>,
rep/@sub]
]];

rep[root]
];


(* ::Input::Initialization:: *)
End[];

Protect[$TreeVertexProperties];
Protect[Node,Leaf];
Protect[NewickTreeQ,NewickToTree,TreeToNewick];
Protect[ClusterToTree,TreeToCluster];
Protect[TreeToGraph,GraphToTree];

EndPackage[];