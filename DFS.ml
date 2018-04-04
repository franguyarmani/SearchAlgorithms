open Printf
  
let file = "lesmis.gml"
let message = "Hello"

let nodes = Hashtbl.create 100;;
let edges = Hashtbl.create 100;;
  
let () =
  
  (* Read file and display the first line *)
  let ic = open_in file in
  try
    while true do
      let line = input_line ic in
      (* read line from in_channel and discard \n *)
      if line = "  node" then begin
          let bracket = input_line ic in
          let idtemp = input_line ic in
          let id =int_of_string
                    (String.sub idtemp 7 ((String.length idtemp)-7)) in 
          let labeltemp = input_line ic in
          let label = String.sub labeltemp 10 ((String.length labeltemp)-10) in
          Printf.printf "name %s\n" label;
          Hashtbl.add nodes id (id, label);
          let (a,b) = Hashtbl.find nodes id in
          Printf.printf "id %d, label %s\n" a b;
          print_endline "NODE"
        end
      else  if line = "  edge" then begin
          let bracket = input_line ic in
          let sourcetemp = input_line ic in
          Printf.printf "test:%send\n" (String.sub sourcetemp 11 ((String.length sourcetemp)-11));
          let targettemp = input_line ic in 
          let valuetemp = input_line ic in 
          let source = int_of_string(String.sub sourcetemp 11 ((String.length sourcetemp)-11)) in
          let target = int_of_string(String.sub targettemp 11 ((String.length targettemp)-11)) in
          let value = int_of_string (String.sub valuetemp 10 ((String.length valuetemp)-10)) in
          
          Hashtbl.add edges (source, target) (source, target, value);
          let (a,b,c) = Hashtbl.find edges (source, target) in
          Printf.printf "source %d, target %d, value %d\n" a b c;
          print_endline "EDGE"
        end
                                
               
          
                                    
    done
 
    
  with End_of_file ->
    close_in ic;;

  let (a,b) = Hashtbl.find nodes 0 in
  Printf.printf "id %s\n" b;  
  flush stdout;                (* write on the underlying device now *)

 
  
  (* normal exit: all channels are flushed and closed *)