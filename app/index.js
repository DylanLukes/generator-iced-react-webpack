'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var generalUtils = require('../util.js');

var IcedReactWebpackGenerator = module.exports = function IcedReactWebpackGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.argument('appname', { type: String, required: false });
  this.appname = this.appname || path.basename(process.cwd());
  this.appname = this._.camelize(this._.slugify(this._.humanize(this.appname)));
  this.scriptAppName = this._.capitalize(this.appname) + generalUtils.appName(this);

  args = ['main'];

  if (typeof this.options.appPath === 'undefined') {
    this.options.appPath = this.options.appPath || 'src';
  }

  this.appPath = this.options.appPath;

  this.hookFor('iced-react-webpack:common', {
    args: args
  });

  this.hookFor('iced-react-webpack:main', {
    args: args
  });

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(IcedReactWebpackGenerator, yeoman.generators.Base);

IcedReactWebpackGenerator.prototype.welcome = function welcome() {
  // welcome message
  if (!this.options['skip-welcome-message']) {
    console.log(this.yeoman);
    console.log(
      'Out of the box I include Webpack and some default React components.\n'
    );
  }
};

IcedReactWebpackGenerator.prototype.readIndex = function readIndex() {
  this.indexFile = this.engine(this.read('../../templates/common/index.html'), this);
};

IcedReactWebpackGenerator.prototype.createIndexHtml = function createIndexHtml() {
  this.indexFile = this.indexFile.replace(/&apos;/g, "'");
  this.write(path.join(this.appPath, 'index.html'), this.indexFile);
};

IcedReactWebpackGenerator.prototype.packageFiles = function () {
  this.template('../../templates/common/_package.json', 'package.json');
  this.copy('../../templates/common/Gruntfile.coffee', 'Gruntfile.coffee');
  this.copy('../../templates/common/gitignore', '.gitignore');
};

IcedReactWebpackGenerator.prototype.styleFiles = function styleFiles() {
  var mainFile = 'main.css';
  var resetFile = 'reset.css';
  this.copy('styles/' + mainFile, 'src/styles/' + mainFile);
  this.copy('styles/' + resetFile, 'src/styles/' + resetFile);
};

IcedReactWebpackGenerator.prototype.imageFiles = function () {
  this.sourceRoot(path.join(__dirname, 'templates'));
  this.directory('images', 'src/images', true);
};

IcedReactWebpackGenerator.prototype.karmaFiles = function () {
  this.copy('../../templates/common/karma.conf.coffee', 'karma.conf.coffee');
};
