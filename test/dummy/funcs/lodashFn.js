const _ = require('lodash');

module.exports = async function lodashFn({ data }) {
  return {
    result: _.sum(data)
  }
}
