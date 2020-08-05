'use strict';
/*
 'use strict' is not required but helpful for turning syntactical errors into true errors in the program flow
 https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode
*/


var util = require('util');

module.exports = {
  testApi: testApi
};

function testApi(req, res) {
  // variables defined in the Swagger document can be referenced using req.swagger.params.{parameter_name}
  const value = req.swagger.params.title.value || 'testApi';
  const result = util.format('This title is, %s!', value);

  // this sends back a JSON response which is a single string
  res.json({result});
}
