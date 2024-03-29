'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var AcuteGenerator = module.exports = function AcuteGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(AcuteGenerator, yeoman.generators.Base);

AcuteGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    type: 'confirm',
    name: 'someOption',
    message: 'Would you like to enable this option?',
    default: true
  }];

  this.prompt(prompts, function (props) {
    this.someOption = props.someOption;

    cb();
  }.bind(this));
};

AcuteGenerator.prototype.app = function app() {
  this.copy('_package.json', 'package.json');
  this.copy('_bower.json', 'bower.json');
};

AcuteGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};

AcuteGenerator.prototype.client = function client(){
  this.mkdir('app');
  this.copy('client/_index.jade', 'app/index.jade');
}

AcuteGenerator.prototype.restServer = function restServer(){
  this.mkdir('server');
  this.copy('server/_server.coffee', 'server/server.coffee');

  this.mkdir('server/data');
  this.copy('server/data/_todos.json', 'server/data/todos.json');
}
