import React, { Component } from 'react';
import {
  NativeModules,
  requireNativeComponent,
  findNodeHandle,
} from 'react-native';
var manager = NativeModules.RNTipsViewManager;
var RNTipsView = requireNativeComponent('RNTipsView', TipsView);
export default class TipsView extends Component {
  constructor(props) {
    super(props)
  }

  export() {
        return new Promise((resolve, reject) => {
            manager.cutImage(
              findNodeHandle(this)
              ,(result) => {
                if (result) {
                    resolve(result);
                } else {
                    reject('bad');
                }
            })
        });
    }

  clear() {
    manager.clear(findNodeHandle(this));
  }

  render() {
    return(
      <RNTipsView {...this.props} />
    )
  }
}
