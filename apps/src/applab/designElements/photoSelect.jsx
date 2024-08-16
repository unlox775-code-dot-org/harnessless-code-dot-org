import $ from 'jquery';
import PropTypes from 'prop-types';
import React from 'react';

import i18n from '@cdo/applab/locale';

import designMode from '../designMode';
import themeValues from '../themeValues';

import BooleanPropertyRow from './BooleanPropertyRow';
import BorderProperties from './BorderProperties';
import ColorPickerPropertyRow from './ColorPickerPropertyRow';
import * as elementUtils from './elementUtils';
import EventHeaderRow from './EventHeaderRow';
import EventRow from './EventRow';
import elementLibrary from './library';
import PropertyRow from './PropertyRow';
import ZOrderRow from './ZOrderRow';

class PhotoChooserProperties extends React.Component {
  static propTypes = {
    element: PropTypes.instanceOf(HTMLElement).isRequired,
    handleChange: PropTypes.func.isRequired,
    onDepthChange: PropTypes.func.isRequired,
  };

  render() {
    const element = this.props.element;

    return (
      <div id="propertyRowContainer">
        <PropertyRow
          desc={i18n.designElementProperty_id()}
          initialValue={elementUtils.getId(element)}
          handleChange={this.props.handleChange.bind(this, 'id')}
          isIdRow
        />
        <PropertyRow
          desc={i18n.designElementProperty_widthPx()}
          isNumber
          initialValue={parseInt(element.style.width, 10)}
          handleChange={this.props.handleChange.bind(this, 'style-width')}
        />
        <PropertyRow
          desc={i18n.designElementProperty_heightPx()}
          isNumber
          initialValue={parseInt(element.style.height, 10)}
          handleChange={this.props.handleChange.bind(this, 'style-height')}
        />
        <PropertyRow
          desc={i18n.designElementProperty_xPositionPx()}
          isNumber
          initialValue={parseInt(element.style.left, 10)}
          handleChange={this.props.handleChange.bind(this, 'left')}
        />
        <PropertyRow
          desc={i18n.designElementProperty_yPositionPx()}
          isNumber
          initialValue={parseInt(element.style.top, 10)}
          handleChange={this.props.handleChange.bind(this, 'top')}
        />
        <ColorPickerPropertyRow
          desc={i18n.designElementProperty_backgroundColor()}
          initialValue={element.style.backgroundColor}
          handleChange={this.props.handleChange.bind(this, 'backgroundColor')}
        />
        <ColorPickerPropertyRow
          desc={i18n.designElementProperty_iconColor()}
          initialValue={element.style.color || '#000000'}
          handleChange={this.props.handleChange.bind(this, 'textColor')}
        />
        <PropertyRow
          desc={i18n.designElementProperty_iconSizePx()}
          isNumber
          initialValue={parseInt(element.style.fontSize, 10)}
          handleChange={this.props.handleChange.bind(this, 'fontSize')}
        />
        <BorderProperties
          element={element}
          handleBorderWidthChange={this.props.handleChange.bind(
            this,
            'borderWidth'
          )}
          handleBorderColorChange={this.props.handleChange.bind(
            this,
            'borderColor'
          )}
          handleBorderRadiusChange={this.props.handleChange.bind(
            this,
            'borderRadius'
          )}
        />
        <BooleanPropertyRow
          desc={i18n.designElementProperty_hidden()}
          initialValue={$(element).hasClass('design-mode-hidden')}
          handleChange={this.props.handleChange.bind(this, 'hidden')}
        />
        <ZOrderRow
          element={this.props.element}
          onDepthChange={this.props.onDepthChange}
        />
      </div>
    );
  }
}

class PhotoChooserEvents extends React.Component {
  static propTypes = {
    element: PropTypes.instanceOf(HTMLElement).isRequired,
    handleChange: PropTypes.func.isRequired,
    onInsertEvent: PropTypes.func.isRequired,
  };

  getPhotoSelectedEventCode() {
    const id = elementUtils.getId(this.props.element);
    const commands = [
      `console.log("${id} photo selected!");`,
      `console.log(getImageURL("${id}"));`,
    ];
    const callback = `function( ) {\n\t${commands.join('\n\t')}\n}`;
    return `onEvent("${id}", "change", ${callback});`;
  }

  insertPhotoSelected = () =>
    this.props.onInsertEvent(this.getPhotoSelectedEventCode());

  render() {
    const element = this.props.element;
    const clickName = i18n.designElementPhotoSelectClickName();
    const clickDescription = i18n.designElementPhotoSelectClickDescription();

    return (
      <div id="eventRowContainer">
        <PropertyRow
          desc={i18n.designElementProperty_id()}
          initialValue={elementUtils.getId(element)}
          handleChange={this.props.handleChange.bind(this, 'id')}
          isIdRow={true}
        />
        <EventHeaderRow />
        <EventRow
          name={clickName}
          desc={clickDescription}
          handleInsert={this.insertPhotoSelected}
        />
      </div>
    );
  }
}

export default {
  PropertyTab: PhotoChooserProperties,
  EventTab: PhotoChooserEvents,
  themeValues: themeValues.photoSelect,

  create: function () {
    const element = document.createElement('label');
    element.setAttribute('class', 'img-upload fa fa-camera');
    element.style.margin = '0';
    element.style.borderStyle = 'solid';
    element.style.overflow = 'hidden';

    elementLibrary.setAllPropertiesToCurrentTheme(
      element,
      designMode.activeScreen()
    );
    element.style.padding = '0';
    element.style.textAlign = 'center';
    element.style.fontSize = '32px';

    element.style.width = '75px';
    element.style.height = '50px';
    element.style.display = 'flex';
    element.style.alignItems = 'center';
    element.style.justifyContent = 'center';
    const newInput = document.createElement('input');
    newInput.type = 'file';
    newInput.accept = 'image/*';
    newInput.capture = 'camera';
    newInput.hidden = true;
    element.appendChild(newInput);
    return element;
  },
  onDeserialize: function (element, updateProperty) {
    // Disable image upload events unless running
    $(element).on('click', () => {
      element.childNodes[0].disabled = !Applab.isRunning();
    });
  },
};
