type operator = Addition | Subtraction | Multiplication | Division

type token =
  | ParensOpen (* "(" *)
  | ParensClose (* ")" *)
  | Operator of operator (* "+", "-", "*", "/" *)
  | Number of string (* "0"..."9" *)
  | String of string
  | Space
  | Unknow of char

let tokenize str =
  String.fold_right
    (fun c acc ->
      match c with
      | '(' -> ParensOpen :: acc
      | ')' -> ParensClose :: acc
      | '+' -> Operator Addition :: acc
      | '-' -> Operator Subtraction :: acc
      | '*' -> Operator Multiplication :: acc
      | '/' -> Operator Division :: acc
      | '0' .. '9' | '.' -> (
          match List.hd acc with
          | Number n -> Number (Char.escaped c ^ n) :: List.tl acc
          | _ -> Number (Char.escaped c) :: acc)
      | ' ' -> Space :: acc
      | _ -> Unknow c :: acc)
    str []

let print =
  List.iter (fun v ->
      match v with
      | ParensOpen -> Format.printf "ParensOpen\n"
      | ParensClose -> Format.printf "ParensClose\n"
      | Operator Addition -> Format.printf "Operator Addition\n"
      | Operator Subtraction -> Format.printf "Operator Subtraction\n"
      | Operator Multiplication -> Format.printf "Operator Multiplication\n"
      | Operator Division -> Format.printf "Operator Division\n"
      | Number n -> Format.printf "Number '%s'\n" n
      | String s -> Format.printf "String '%s'\n" s
      | Space -> Format.printf "Space\n"
      | Unknow c -> Format.printf "Unknow '%c'\n" c)

let%test _ =
  let l = tokenize "(* (+ 4 52) (- 2 1.2))" in
  (* let _ = print l in *)
  l
  = [
      ParensOpen;
      Operator Multiplication;
      Space;
      ParensOpen;
      Operator Addition;
      Space;
      Number "4";
      Space;
      Number "52";
      ParensClose;
      Space;
      ParensOpen;
      Operator Subtraction;
      Space;
      Number "2";
      Space;
      Number "1.2";
      ParensClose;
      ParensClose;
    ]
