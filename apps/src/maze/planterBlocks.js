/**
 * Blocks specific to Planter
 */
var blockUtils = require('../block_utils');
var BlockStyles = require('../blockly/constants').BlockStyles;
var BlockColors = require('../blockly/constants').BlockColors;

var msg = require('./locale');

exports.install = function (blockly, blockInstallOptions) {
  var generator = blockly.getGenerator();
  blockly.JavaScript = generator;

  blockUtils.generateSimpleBlock(blockly, generator, {
    name: 'planter_plant',
    helpUrl: '',
    title: msg.plant(),
    titleImage: undefined,
    tooltip: msg.plantTooltip(),
    functionName: 'Maze.plant',
  });

  blockly.Blocks.planter_ifAtSoil = {
    helpUrl: '',
    init: function () {
      Blockly.cdoUtils.handleColorAndStyle(
        this,
        BlockColors.LOGIC,
        BlockStyles.LOGIC
      );
      this.appendDummyInput().appendField(
        [msg.ifCode(), msg.at(), msg.soil()].join(' ')
      );
      this.setInputsInline(true);
      this.appendStatementInput('DO').appendField(msg.doCode());
      this.setPreviousStatement(true);
      this.setNextStatement(true);
    },
  };

  generator.planter_ifAtSoil = function () {
    var argument = `Maze.atSoil('block_id_${this.id}')`;
    var branch = generator.statementToCode(this, 'DO');
    var code = `if (${argument}) {\n${branch}}\n`;
    return code;
  };

  blockly.Blocks.planter_ifAtSprout = {
    helpUrl: '',
    init: function () {
      Blockly.cdoUtils.handleColorAndStyle(
        this,
        BlockColors.LOGIC,
        BlockStyles.LOGIC
      );
      this.appendDummyInput().appendField(
        [msg.ifCode(), msg.at(), msg.sprout()].join(' ')
      );
      this.setInputsInline(true);
      this.appendStatementInput('DO').appendField(msg.doCode());
      this.setPreviousStatement(true);
      this.setNextStatement(true);
    },
  };

  generator.planter_ifAtSprout = function () {
    var argument = `Maze.atSprout('block_id_${this.id}')`;
    var branch = generator.statementToCode(this, 'DO');
    var code = `if (${argument}) {\n${branch}}\n`;
    return code;
  };
};
