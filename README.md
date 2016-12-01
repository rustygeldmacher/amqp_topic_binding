# AmqpTopicBinding

This simple gem implements the matching algorithm for AMQP topic exchange 
routing key bindings, allowing you to do the same matching that is performed
at the exchange when the broker is deciding what to send to a queue.

Wildcards are supported.

## Usage

Simply ask the matcher if a routing key matches a pattern:

```ruby
> AmqpTopicBinding.new('foo.bar.*').matches?('foo.bar.baz')
=> true
> AmqpTopicBinding.new('foo.bar.*').matches?('foo.bar')
=> false
> AmqpTopicBinding.new('foo.#').matches?('foo.bar.baz')
=> true
```
