# Day 1

## Data

`(def x 1)` defines data.

### Lists

```clojure
(list 1 2 3 4)
'(1 2 3 4)
```

Operators include `first`, `rest`, `last`, and `cons` (join `H|T` together).

### Vectors

```clojure
[:some :collection :of :elements]
```

Like lists, but optimised for random access. Used for data, while lists are usually used for code. Vectors include the `nth` operator: `(nth [:jabba :grievous :malak] 2)` returns `:malak`.

### Sets

```clojure
(def spacecraft #{:x-wing :y-wing :tie-fighter})
```

### Maps

```clojure
{:chewie :wookie, :lea :human}
```

The comma is for eyes only and is ignored by the parser.

```clojure
user=> (merge-with + {:y-wing 2, :x-wing 4} {:tie-fighter 2 :x-wing 3})
{:tie-fighter 2, :y-wing 2, :x-wing 7}
```
That's rad! Did you see how it added the value of `:x-wing` together from the two maps?

## Functions

Remember that `defn` is a keyword for writing a function.

```clojure
(defn force-it
    "The first function a young Jedi needs"
    []
    (str "Use the force," "Luke"))
```

```clojure
(let [{name :name} person] (str "The person's name is " name))
```

I'm confused by the `{name :name} person` part. I would be more comfortable with `name (:name person)`. That also works by the way. Let me try to understand. The second form is easy: bind the symbol `name` to the result of `(:name person)`, which means it's bound to `"Jabba"`. The tricky form creates a new map and binds that to the `person` map. Lookee here:

```clojure
user=> (let [{name :name, pro :profession} person] (str name " the " pro))
"Jabba the Gangster"
```

Binding `{name :name}` to `person` seems to bind like this: `name -> :name -> person -> "Jabba"`. It makes my head hurt. Here's some help: [Functions in Clojure](http://clojure-doc.org/articles/language/functions.html#destructuring-of-function-arguments)

Here's an anonymous function. It's quite a lot like anonymous functions in Erlang.

```clojure
user=> (def people ["Leia" "Lando" "Mark" "Pauline" "Darth Vader"])
#'user/people
user=> (map (fn [W] (* 2 (count W))) people)
(8 10 8 14 22)
```

There's also a short form: `(map #(* 2 (count %)) people)`. `#` begins an anonymous function and `%` gets bound to each item in the sequence (in our case each word in `people`.


## Homework

### Find

- Examples using Clojure sequences
    - [Clojure - Sequences](http://clojure.org/reference/sequences)
    - [Sequences – Inside Clojure](http://insideclojure.org/2015/01/02/sequences/)
    - [Clojure from the ground up: sequences](https://aphyr.com/posts/304-clojure-from-the-ground-up-sequences)
- The formal definition of a Clojure function
    - [clojure/core.clj at 010864f8ed828f8d261807b7345f1a539c5b20df · clojure/clojure](https://github.com/clojure/clojure/blob/010864f8ed828f8d261807b7345f1a539c5b20df/src/clj/clojure/core.clj#L283)
    - The documentation says that `(defn dubbel [x] (* 2 x))` is simply a macro that expands to `(def dubbel (fn [x] (* 2 x)))`.
- A script for quickly invoking the repl in your environment
    - Um... this works fine: `lein repl`

### Do

- Implement a function called `(big st n)` that returns true if a string st is longer than `n` characters.
- Write a function called `(collection-type col)` that returns `:list`, `:map`, or `:vector` based on the type of collection `col`.

#### Implement a function called `(big st n)` that returns true if a string st is longer than `n` characters.

```clojure
(def astr "yomonogo")
(defn biggerthan? [n string]
  (> (count string) n))
(biggerthan? 2 astr)         ; TRUE
(biggerthan 200 astr)        ; TRUE
```

#### Write a function called `(collection-type col)` that returns `:list`, `:map`, or `:vector` based on the type of collection `col`.

```clojure
(def alis '(1 2 3 :rock))
(def amap {:bruce "Batman" :clark "Superman" :tom "real man"})
(def avec [:yolo :foshizzle :bae])
(defn whatizzit
  "I'll bite a collection and tell you what it is."
  [col]
  (let [char (str (first (str col)))]
    (if (= char "[") :vector
    (if (= char "(") :list
    (if (= char "{") :map)))))

(whatizzit avec)
(whatizzit amap)
```

# Day 2

Oh! My! Fibonacci and factorial in Clojure are rapturous!

```clojure
(defn fib-pair [[a b]] [b (+ a b)])
(take 10 (map first
    (iterate fib-pair [1 1])))
(nth (map first
    (iterate fib-pair [1 1])) 500)

(defn factotum [n] (apply * (iterate inc 1)))
```
