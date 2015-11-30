- https://leanpub.com/purescript/read

# Notes

## Chapter 05

- row polymorphism

```haskell
> let showPerson { first: x, last: y } = y ++ ", " ++ x

> :type showPerson
forall r. { first :: String, last :: String | r } -> String

-- What is the type variable r here? Well, if we try showPerson in PSCi, we see something interesting:
-- We can read the new type signature of showPerson as “takes any record with first and last fields
-- which are Strings and any other fields, and returns a String”.
-- This function is polymorphic in the row r of record fields, hence the name row polymorphism.

> showPerson { first: "Phil", last: "Freeman" }
"Freeman, Phil"

> showPerson { first: "Phil", last: "Freeman", location: "Los Angeles" }
"Freeman, Phil"

```

# questions

- [ ] how to derive type class
