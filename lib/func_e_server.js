const fs = require("fs");
const http = require("http");

// Get the port number from the cli arguments or use the default port number
const args = require("./support/args")();

const PORT = args.port || 3030;

/**
 * Load all the functions from the provided directory.
 */
let functions = fs.readdirSync(args.functions_path).reduce((obj, file) => {
  const isFunction = file.endsWith(".js");

  if (isFunction) {
    const functionName = file.split(".")[0];
    const functionPath = args.functions_path + "/" + file;
    obj[functionName] = require(functionPath);
  }

  return obj;
}, {});

const invalidRequestMethodError = JSON.stringify({
  message: "This server only accepts POST requests"
})

const functionExecutionError = (err) => JSON.stringify({
  error: err.message
});

const functionNotFoundError = (name) => JSON.stringify({
  error: `Function "${name}" not loaded. Check the function name or restart the server.`
})

function setDefaultHeaders(res) {
  res.setHeader("Content-Type", "application/json");
}

function handler(req, res) {
  if (req.method != "POST") res.end(invalidRequestMethodError);

  setDefaultHeaders(res)

  let post_data = "";

  req.on("data", chunk => post_data += chunk);
  req.on("end", () => {
    const data = JSON.parse(post_data);
    const fn = functions[data.name];

    if (!fn) {
      res.statusCode = 404;
      res.end(functionNotFoundError(data.name));
    } else {
      fn(data.payload)
        .then((result) => {
          res.statusCode = 200;
          res.end(JSON.stringify(result));
        }).catch((err) => {
          res.statusCode = 500;
          res.end(functionExecutionError(err));
        });
    }
  });
}

const server = http.createServer(handler);

server.listen(PORT, () => console.log(`\nRunning FuncE server on http://localhost:${PORT}/\n`));
