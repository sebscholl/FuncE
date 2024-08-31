# Funcy

Funcy (pronounced "FUNK-E") is a Ruby gem that provides a clean interface between Node.js functions and Ruby applications. It allows developers to leverage JavaScript code within a Ruby environment, offering a Function-as-a-Service (FaaS)-like experience.

## Requirements

To use Funcy, you must have Node.js installed in the environment where your Ruby application is running. This applies to both local development and production servers.

You can check if Node.js is installed by running:

```bash
node -v
```

If Node.js is not installed, you can download it from the [official Node.js website](https://nodejs.org/) or install it via a package manager like `brew` (for macOS) or `apt` (for Linux).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'funcy'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install funcy
```

## Usage

### Basic Example

First, require the gem in your Ruby application:

```ruby
require 'funcy'
```

To use a Node.js function, create a JavaScript file with the function you want to execute:

**Example `helloFn.js`:**

```javascript
/** 
 * app_root/funcy/functions/helloFn.js
 */
module.exports = function(input) {
  return { 
    message: `Hello ${input.planet}!`
  };
};
```

Then, call the function from your Ruby code:

```ruby
puts Funcy.run('helloFn', { planet: 'world' })
=> Output: { message: "Hello world!" }
```

### Require and Async

Funcy works with both asyncronous functions and requiring packages/files. Funcy is simply CommonJS and doesn't support ES Modules (ESM), so note that import statements are not supported. 

**Example `addNumbers.js`:**

```javascript
/**
 * app_root/funcy/functions/addNumbers.js
 */
const _ = require('lodash')

module.exports = async function(input) {
  await new Promise(
    resolve => setTimeout(() => resolve('Coffee break...'), 1000)
  );

  return {
    result: _.sum(input.a, input.b)
  }
};
```

```ruby
result = Funcy.run('addNumbers', { a: 5, b: 10 })
puts result
=> { result: 15 }
```

### Custom Configuration

Funcy is designed to work out-of-the-box, but you can customize its behavior with various options:

```ruby
Funcy.configure do |config|
  config.parser = :json                            # Set the response parser (:plain, :json)
  config.timeout = 5000                            # Set a timeout on all functions (5000 milliseconds)
  config.memory_limit = '512MB'                    # Set memory limit on all functions (512MB)
  config.fn_dir_path = 'root/funcy'                 # Set the relative path to the Funcy directory
  config.node_path = '/usr/local/bin/node'         # Set the Node.js binary path
end
```

## Error Handling

Funcy will raise an exception if there is an error during the execution of the JavaScript function. You can handle these exceptions in your Ruby code:

```ruby
begin
  result = Funcy.run('someFunction', { key: 'value' })
rescue Funcy::Error => e
  puts "An error occurred: #{e.message}"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/your_username/funcy](https://github.com/your_username/funcy). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html) code of conduct.

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgements

Funcy was inspired by the need to bridge the gap between Ruby and Node.js, enabling developers to utilize the best of both worlds without the hassle of managing separate services.
