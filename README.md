# sexpr

[![GitHub release](https://img.shields.io/github/release/grimmigerFuchs/sexpr.svg)](https://github.com/grimmigerFuchs/sexpr/releases)

A small s-expression parser based on [fast-sexpr](https://github.com/benthepoet/fast-sexpr).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     sexpr:
       github: grimmigerFuchs/sexpr
   ```

2. Run `shards install`

## Usage

```crystal
require "sexpr"

source = "
(test (arg1 arg2) something else)
(another object (with (nests (too))))
"

pp Sexpr.parse(source)

# [["test", ["arg1", "arg2"], "something", "else"],
#  ["another", "object", ["with", ["nests", ["too"]]]]]
```

## Contributing

1. Fork it (<https://github.com/grimmigerFuchs/sexpr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Dominic Grimm](https://github.com/grimmigerFuchs) - creator and maintainer
