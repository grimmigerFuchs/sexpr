# sexpr

A small s-expression parser based on [fast-sexpr](https://www.npmjs.com/package/fast-sexpr).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     sexpr:
       github: grimmigerfuchs/sexpr
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
"
```

## Contributing

1. Fork it (<https://github.com/grimmigerfuchs/sexpr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [grimmigerFuchs](https://github.com/grimmigerfuchs) - creator and maintainer
