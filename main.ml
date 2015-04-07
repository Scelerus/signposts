let debug = ref true

(* this next section contains all the parameters that can be set.
   Most of these concern the heuristics being employed *)

let signposts = [ ("cum","tum"); ("et","et"); ("ut","sic"); ("ut", "ita"); ("quidem","tamen"); ("quidem", "sed"); ("vel","vel"); ("aut", "aut");  ("tam", "ut"); ("ita", "ut"); ("adeo", "ut")]

let max_words_between_signposts = 12

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

let rec remove_word_internal word rgwords acc =
  match rgwords with [] -> acc 
    | hd :: tl -> if hd = word 
      then (List.rev acc)@tl 
      else remove_word_internal word tl (hd :: acc)

let remove_word word rgwords =
  remove_word_internal word rgwords []

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

    let rec count_words lines =
      match lines with [] -> 0 | hd :: tl ->
	let words = List.map (String.lowercase) (Str.split (Str.regexp (Str.quote " ")) hd) in
	(List.length words) + count_words tl
    in

    Printf.printf "%d words in %s\n" (count_words !lines) Sys.argv.(1);

    let rec process_lines lines =
      match lines with [] -> () | hd :: tl ->
	(*Printf.printf "hd is %s\n" hd;*)
	let words = List.map (String.lowercase) (Str.split (Str.regexp (Str.quote " ")) hd) in
	  if List.length words > 0 then begin
	let by_period = Str.split (Str.regexp (Str.quote ".")) (List.hd words) in
	  if List.length by_period = 2 then begin cur_letter := List.hd words end end;
	let rec look_for_signposts words signposts =
	  match signposts with [] -> () | (fst, snd) :: tl ->
	    let rec look_through_words words fst snd fLookingForFirst counter words_left =
	      match words with [] -> [] | hd :: tl ->
		if fLookingForFirst then 
		  begin if hd = fst 
		         then begin let tl = look_through_words tl fst snd false 0 tl in look_through_words tl fst snd true 0 tl end 
		         else look_through_words tl fst snd true 0 tl
		  end else
		    if counter > max_words_between_signposts then words_left else begin

		    if hd = snd 
		    then begin Printf.printf "Found %s, %s pair\n" fst snd; remove_word hd words_left 
		    end else (* check for full stops *)
		      if fFullStops && (contains hd "." || contains hd ":") then words_left
		      else look_through_words tl fst snd false (counter + 1) words_left
		end
	    in
	    look_through_words words fst snd true 0 words; look_for_signposts words tl
	in
	look_for_signposts words signposts;  
	process_lines tl
    in
      process_lines !lines;
    Printf.printf "done\n"
;;

main ();;
