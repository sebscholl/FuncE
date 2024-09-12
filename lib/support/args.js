/**
 * Extract the arguments from the command line and return them as an object
 * of key value pairs. Args are expected to be in the format --key=value.
 */
module.exports = () => {
  let args = {};

  process.argv.slice(2).forEach(arg => {
    if (arg.startsWith('--')) {
      const split = arg.indexOf('=');
      args[arg.substring(2, split)] = arg.substring(split + 1);
    }
  })

  return args;
};