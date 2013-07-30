'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');

var MockGenerator = module.exports = function MockGenerator(args, options, config) {
  yeoman.generators.NamedBase.apply(this, arguments);
};

util.inherits(MockGenerator, yeoman.generators.NamedBase);

MockGenerator.prototype.files = function files() {
  var mockTemplate = '{ "initialData": [] }'
  this.write('server/data/' + this.name + '.json', mockTemplate);
};
