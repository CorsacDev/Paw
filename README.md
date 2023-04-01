# The Paw Programming Language

..

# Code Example

```rs
import io;

let main = {
  io.println "Hello, world!";
}
```

```rs
import io; 

// concat strings
let hello message = io.println "Hello, " ++ message;

let main = {
  hello "world!"
}

```

```rust
import io;

type Option t : Some t | None

let map (o: Option `a) (f: `a -> `b): Option `b = match o {
  Some v = Some f v,
  None = None
};

let main = {
  // type: Option int
  let data = Some 4;
  // Lambda function
  map (\ v = io.println v) data; // print "4"
}

```

# License

Paw is [MIT licensed](LICENSE).
