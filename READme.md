# FuncE

FuncE (pronounced "FUNK-E") is a Ruby gem that provides a clean interface between Node.js functions and Ruby apps. It lets developers to call JavaScript functions from their Ruby code, offering a Function-as-a-Service (FaaS)-like experience.

## Requirements

To use FuncE, you must have Node.js installed in the environment where your Ruby application is running. This applies to both local development and production servers.

You can check if Node.js is installed by running:

```bash
node -v
```

If Node.js is not installed, you can download it from the [official Node.js website](https://nodejs.org/) or install it via a package manager like `brew` (for macOS) or `apt` (for Linux).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'func_e'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install func_e
```

Install the `funcs` directory using the rake task.

```sh
bundle exec rake func_e:install
```

## Usage

### Basic Example

First, require the gem in your Ruby application. If you're using `FuncE` in a Rails application, it will get loaded via railtie.

```ruby
require 'func_e'
```

To use a Node.js function, create a JavaScript file with the function you want to execute:

**Example `helloFn.js`:**

```javascript
/** 
 * app_root/funcs/helloFn.js
 */
module.exports = function(input) {
  return { 
    result: `Hello ${input.planet}!`
  };
};
```

Then create an instance of the function using the `FuncE::Func` class, supplying the name of the JS file, and run it.

```ruby
func = FuncE::Func.new('helloFn')

func.run({ planet: 'world' })

puts func
=> <FuncE::Func:0x00007fe0cd39f4d0
 @name="helloFn",
 @path=#<Pathname:/home/sebscholl/func_e/test/dummy/funcs/helloFn.js>,
 @payload={:planet=>"world"},
 @result={:result=>"Hello, world!"},
 @run_at=Sat, 31 Aug 2024 19:23:57.129544604 UTC +00:00,
 @run_time=0.172700613
>
```

The return value of the `run` method will be the functions result. However, the result is also gets stored on the instance itself.

### Requires and Async

FuncE works with both asyncronous functions and requiring packages/files. FuncE is simply CommonJS and doesn't support ES Modules (ESM), so note that import statements are not supported. 

Simply change into the `funcs` directory and use `npm` or `yarn` to install any required packages.

```sh
cd funcs
npm i --save lodash
```

**Example `addNumbers.js`:**

```javascript
/**
 * app_root/funcs/addNumbers.js
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
puts FuncE::Func.new('addNumbers').run({ a: 5, b: 10 })
=> { result: 15 }
```

### Custom Configuration

FuncE is designed to work out-of-the-box, but you can customize its behavior with:

```ruby
FuncE.configure do |config|
  config.fn_dir_path = 'my_funcs_dir' # Set the relative path to the FuncE directory.
  config.local_server_port = 3030 # Set a port number for the local node server to run on.
  config.local_server = false # Call your functions via a node server running on localhost
end
```

#### Local Server

By default, FuncE will load and executes a function code when the `run` or `exec` method is called. This can lead to slow execution time, as the function's file and any required packages all need to get read on each execution.

Setting `local_server_port = true` when configuring the gem will spin up a node server on port 3030 (or a configured port number) and make functions available via POST requests on localhost. The `FuncE` module will automatically use the server for calling functions when `local_server_port = true` is set; using a server or the default CLI runner has no impact on how you write your code or methods you call. 

The benefits of the server option is speed. Function calls that take ~300ms using the runner may be ~15ms using the server. Additionally, if for some reason you don't want to use the `FuncE` modules and classes when calling functions, requests can be made directly to the localhost endpoint like so:

```sh
# The payload argument will be passed directly to the function. Therefore it is recommended to use a single object
# as the function argument inside of which you can have multiple entries.
curl -X POST http://localhost:3030 -H 'Content-Type: application/json' -d '{
  "name": "myFunctionName",
  "payload": {
    "someArg": "my function expects"
  }
}'
```

## Error Handling

FuncE will return an error payload if an exception was raised during execution.

```ruby
FuncE::Func.new('addNumbers').run(1)
=> { 
  error: 'An error occurred while executing the node function.',
  message: e.message
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/your_username/FuncE](https://github.com/your_username/FuncE). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html) code of conduct.

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgements

FuncE was inspired by the need to bridge the gap between Ruby and Node.js, enabling developers to utilize the best of both worlds without the hassle of managing separate services.
