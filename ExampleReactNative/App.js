/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {useEffect} from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Pressable,
  TextInput,
  Alert  
} from 'react-native';

import {
  Colors,
  Header
} from 'react-native/Libraries/NewAppScreen';

import { NativeModules, NativeEventEmitter } from 'react-native';
const { PaylinkReactModule } = NativeModules;

const Section = ({children, title}): Node => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
     
    </View>
  );
};

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const emitter = new NativeEventEmitter(PaylinkReactModule);

  useEffect(() => {
    PaylinkReactModule.configure("910162c0-a0e6-40b8-b66d-f6a9d56bee0f", "c7667cce1d82212b39090e697e6cf1a300453d8af730ccce0878307b9fb43034");
  });

  const [redirectionURL, onRedirectURLChange] = React.useState("https://preprodenv.pengpay.io/paycompleted");
  const [amount, onAmountChange] = React.useState("11.3");
  const [reference, onReferenceChange] = React.useState("Sample Reference");
  const [description, onDescriptionChange] = React.useState("Sample Description");
  const [accountType, onAccountTypeChange] = React.useState("SortCode");
  const [identification, onIdentificationChange] = React.useState("10203012345678");
  const [name, onNameChange] = React.useState("John Doe");
  const [currency, onCurrencyChange] = React.useState("GBP");

  const initiate = () => {
    var request = {
      "amount" : +amount,
      "redirect_url" : redirectionURL,
      "reference" : reference,
      "description" : description,
      "creditor_account" : {
        "currency" : currency,
        "identification" : identification,
        "type" : accountType,
        "name" : name
      }
    }; 

    emitter.addListener(
      'initiate',
      result => {
        showResultAlert(result.status);        
      }
    );

    PaylinkReactModule.initiate(request, callback => {});
  }

  const showResultAlert = (message) => {
    Alert.alert(
      "Payment sResult",
      message,
      [       
        { text: "OK", onPress: () => console.log("OK Pressed") }
      ]
    );
  }

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <View style={styles.titleContainer}> 
        <Text 
          style={styles.title}>
          ExampleReactNative
        </Text>
      </View>
      <ScrollView
        contentInsetAdjustmentBehavior='scrollableAxes'
        style={backgroundStyle}
        height= '85%'>
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <View>
            <Text style={styles.inputLabel}>Redirect URL</Text>
            <TextInput
              style={styles.input}
              value={redirectionURL}
              onChangeText={onRedirectURLChange}
              placeholder="Enter"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Amount</Text>
            <TextInput
              style={styles.input}
              value={amount}
              onChangeText={onAmountChange}
              placeholder="Enter"
              keyboardType= "numeric"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Reference (Max: 18)</Text>
            <TextInput
              style={styles.input}
              value={reference}
              onChangeText={onReferenceChange}
              placeholder="Enter"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Description (Max: 255)</Text>
            <TextInput
              style={styles.input}
              value={description}
              onChangeText={onDescriptionChange}
              placeholder="Enter"
            />
           </View>
           <Text style={styles.sectionLabel}>Creditor Account</Text>
           <View>
            <Text style={styles.inputLabel}>Type ("SortCode", "Iban", "Bban")</Text>
            <TextInput
              style={styles.input}
              value={accountType}
              onChangeText={onAccountTypeChange}
              placeholder="Enter"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Identification</Text>
            <TextInput
              style={styles.input}
              value={identification}
              onChangeText={onIdentificationChange}
              placeholder="Enter"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Name</Text>
            <TextInput
              style={styles.input}
              value={name}
              onChangeText={onNameChange}
              placeholder="Enter"
            />
           </View>
           <View>
            <Text style={styles.inputLabel}>Currency("GBP", "EUR", etc.)</Text>
            <TextInput
              style={styles.input}
              value={currency}
              onChangeText={onCurrencyChange}
              placeholder="Enter"
            />
           </View>
        </View>
      </ScrollView>
        <Pressable style={styles.button} onPress={initiate}>
          <Text style={styles.text}>Pay with Paylink</Text>
        </Pressable>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
    paddingVertical: 24,
    marginTop: 24,
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
  titleContainer: {
    backgroundColor: '#3F51B5',
    flex: 0,
    height: 50,
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 20,
    lineHeight: 21,
    fontWeight: 'bold',
    letterSpacing: 0.25,
    color: 'white'
  },
  button: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 4,
    elevation: 3,
    backgroundColor: '#3F51B5',
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
  input: {
    height: 40,
    margin: 12,
    borderWidth: 1,
    padding: 10,
    borderRadius: 8,
    borderColor: '#3F51B5',
  },
  inputLabel: {
    height: 30,
    margin: 0,
    padding: 10,
  },
  sectionLabel: {
    height: 30,
    margin: 0,
    padding: 10,
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default App;