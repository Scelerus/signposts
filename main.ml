let debug = ref true

(* this next section contains all the parameters that can be set.
   Most of these concern the heuristics being employed *)

let signposts = [("cum","tum")]
(* [("ut","sic"); ("et","et"); ("cum","tum"); ("velut", "sic")]*)

let max_words_between_signposts = 8

let fFullStops = true

(* end of parameters *)

(* for whatever reason ocaml doesn't support this natively, so I rolled my own *)
let contains s1 s2 =
    let r2 = Str.regexp (Str.quote s2) in
    let found = ref false in
    (try
      let _ = Str.search_forward r2 s1 0 in
      found := true
    with Not_found -> found := false);
    !found

let main () =
  let lines = ref [] in
  let filename = Sys.argv.(1) in
  let ic = open_in filename in
  try
    while true do
      lines := (input_line ic) :: !lines
    done
  with _ -> begin if !debug then Printf.printf "lines read in: %d\n" (List.length !lines) end;
    lines := List.rev !lines;
    let cur_letter = ref "" in
    let rec process_lines lines =
      match lines with [] -> () | hd :: tl ->
	(*Printf.printf "hd is %s\n" hd;*)
	let words = Str.split (Str.regexp (Str.quote " ")) hd in
	  if List.length words > 0 then begin
	let by_period = Str.split (Str.regexp (Str.quote ".")) (List.hd words) in
	  if List.length by_period = 2 then begin cur_letter := List.hd words end end;
	let rec look_for_signposts words signposts =
	  match signposts with [] -> () | (fst, snd) :: tl ->
	    let rec look_through_words words fst snd fLookingForFirst counter =
	      match words with [] -> () | hd :: tl ->
		if fLookingForFirst then 
		  begin if hd = fst 
		         then (look_through_words tl fst snd false 0; look_through_words tl fst snd true 0) 
		         else look_through_words tl fst snd true 0 
		  end else
		    if hd = snd && counter < max_words_between_signposts 
		    then Printf.printf "Found %s, %s pair in %s\n" fst snd !cur_letter 
		    else (* check for full stops *)
		      if fFullStops && (contains hd "." || contains hd ":") then ()
		      else look_through_words tl fst snd false (counter + 1)
	    in
	    look_through_words words fst snd true 0; look_for_signposts words tl
	in
	look_for_signposts words signposts;  
	process_lines tl
    in
      process_lines !lines;
    Printf.printf "done\n"
;;

main ();;
