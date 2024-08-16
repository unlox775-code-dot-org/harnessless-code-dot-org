import PropTypes from 'prop-types';
import React, {Component} from 'react';

import Button from '@cdo/apps/legacySharedComponents/Button';
import i18n from '@cdo/locale';

export default class PrintReportButton extends Component {
  static propTypes = {
    onClick: PropTypes.func.isRequired,
  };

  render() {
    return (
      <div>
        <Button
          __useDeprecatedTag
          onClick={this.props.onClick}
          color={Button.ButtonColor.brandSecondaryDefault}
          text={i18n.printReport()}
          icon="print"
          iconClassName="fa"
          size={'narrow'}
          style={styles.button}
          id="uitest-standards-print-button"
        />
      </div>
    );
  }
}

const styles = {
  button: {
    margin: '20px 0px',
  },
};
