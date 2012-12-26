open Graph.Pack.Digraph

let cpg = (Hashtbl.create 1 : 
             ((int list, Graph.Pack.Digraph.t) Hashtbl.t));;

let cpg_init id = 
  Hashtbl.add cpg [] (create ())
;;

let cpg_copy id1 id2 = 
  let g1 = Hashtbl.find cpg id1 in
  let g2 = copy g1 in
    Hashtbl.add cpg id2 g2
;;

let cpg_add_child id p1 p2 c = 
  let g = Hashtbl.find cpg id in
  let vp1 = V.create p1 in
  let vp2 = V.create p2 in
  let vc = V.create c in
    add_vertex g vc;
    add_edge g vc vp1;
    add_edge g vc vp2
;;    

let cpg_update_rule id r1 r2 =
  let g = Hashtbl.find cpg id in
  let vr1 = V.create r1 in
  let vr2 = V.create r2 in
  let r1_in_edges = fold_pred (fun v vs -> v::vs) g vr1 [] in
  let r1_out_edges = fold_succ (fun v vs -> v::vs) g vr1 [] in
    remove_vertex g vr1;
    add_vertex g vr2;
    List.iter (fun v -> add_edge g v vr2) r1_in_edges;
    List.iter (fun v -> add_edge g vr2 v) r1_out_edges;
    ()
;;
      
  
