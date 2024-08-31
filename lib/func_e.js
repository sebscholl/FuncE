/**
 * This script is an entrypoint for the JavaScript service. It will expect a 
 * script name as an argument and will execute the script with the provided
 * arguments. The script must be located in the node/functions directory. And
 * the arguments must be provided as a JSON string to be parsed.
 * 
 * All functions must return a value that can be serialized and exposed arguments
 * as an object. The function will be executed with the provided arguments and 
 * always return an Promise that resolves to the result of the function. Thus
 * all functions must be asynchronous.
 */

/**
 * Extract the arguments from the command line.
 */
let args = {};

process.argv.slice(2).forEach(arg => {
  if (arg.startsWith('--')) {
    const split = arg.indexOf('=');
    args[arg.substring(2, split)] = arg.substring(split + 1);
  }
})

// If any of the required arguments are missing, throw an error.
if (!args.path) throw new Error('Missing function name (--fn=<FUNCTION_NAME>');

// If the payload is provided, parse it as JSON. Otherwise, set it to an empty object.
const jsonPayload = args.payload ? JSON.parse(args.payload) : {};

// Wrap the function in an anonymous async function and execute it.
(async (params) => {
  // Execute the function.
  const result = await require(args.path)(params);

  // Insure the result is an object that can be serialized.
  if (typeof result !== 'object') {
    throw new Error('Function must return an object');
  }

  // Write the result to stdout.
  process.stdout.write(
    JSON.stringify(result)
  );
})(jsonPayload);