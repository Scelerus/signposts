let debug = ref true

let main () =
  let lines = ref [] in
  try
    while true do
      lines := (read_line()) :: !lines
    done
  with _ -> begin if !debug then Printf.printf "lines read in: %d\n" (List.length !lines) end;
    Printf.printf "done\n"
;;

main ();;
