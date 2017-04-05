/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  ImageStore
} from 'react-native';
import TipsView from 'react-native-tipsview';

export default class tips extends Component {
  constructor(props) {
    super(props);
    this.state = {
      imageURI:'',
    };
  }
  render() {
    return (
      <View style={styles.container}>
        <TipsView ref='tipsView' lineColor='red' lineWidth={8} style={styles.tipsViewStyle}>
          {
            this.state.imageURI.length > 0 ? (
              <Image source={{uri:this.state.imageURI}} style={styles.previewStyle}/>
            ) : null
          }
        </TipsView>
        <TouchableOpacity onPress={()=>{
          this.refs.tipsView.clear();
          this.setState({imageURI:''});
        }}>
          <Text style={styles.text}>{'clear'}</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={()=>{
          this.refs.tipsView.export().then(result=>{
            this.setState({imageURI:result});
          }, error=>{
            console.warn(error);
          });
        }}>
          <Text style={styles.text}>{'cut'}</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  tipsViewStyle: {
    flex:1,
    backgroundColor:'white',
  },
  previewStyle: {
    position:'absolute',
    width: 100,
    height: 100,
    resizeMode:'contain',
  },
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
  },
  text: {
    alignSelf: 'center',
    padding: 20,
  }
});

AppRegistry.registerComponent('tips', () => tips);
