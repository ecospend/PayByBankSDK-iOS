/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Pressable
} from 'react-native';

import {
  Colors,
  Header
} from 'react-native/Libraries/NewAppScreen';

import { NativeModules } from 'react-native';
const { PaylinkReactModule } = NativeModules;

const Section = ({children, title}): Node => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
};

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const configure = () => {
    PaylinkReactModule.configure('Paylink', 'SDK');
  };

  const beep = () => {
    PaylinkReactModule.beep();
  };

  const openNativeVC = () => {
    PaylinkReactModule.openNativeVC();
  };

  const testPromise = () => {
    PaylinkReactModule.authenticate('berk')
              .then(function() {
                console.log('promise success');
              }, function(error) {
                console.log("Code => " + error.code);
                console.log("Message => " + error.message);
                console.log("User Info => " + JSON.stringify(error.userInfo));
              })
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>

          <Pressable style={styles.button} onPress={configure}>
            <Text style={styles.text}>Configure</Text>
          </Pressable>

           <Pressable style={styles.button} onPress={beep}>
            <Text style={styles.text}>Beep</Text>
          </Pressable>

          <Pressable style={styles.button} onPress={openNativeVC}>
            <Text style={styles.text}>NativeViewController</Text>
          </Pressable>

          <Pressable style={styles.button} onPress={testPromise}>
            <Text style={styles.text}>Test Promise</Text>
          </Pressable>

        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
    paddingVertical: 24,
    marginTop: 24,
    backgroundColor: 'red'
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
  button: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 4,
    elevation: 3,
    backgroundColor: '#01a3a4',
    marginHorizontal: 24,
    marginVertical: 8
  },
  text: {
    fontSize: 16,
    lineHeight: 21,
    fontWeight: 'bold',
    letterSpacing: 0.25,
    color: 'white',
  },
});

export default App;