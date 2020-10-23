/*
Copyright (c) Facebook, Inc. and its affiliates.
All rights reserved.

This source code is licensed under the license found in the
LICENSE file in the root directory of this source tree.
*/

___INFO___

{
  "type": "CLIENT",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Facebook Conversions API Client",
  "brand": {
    "id": "brand_dummy",
    "displayName": "Facebook"
  },
  "description": "A server-side client template that listens and translates event information from the Facebook Pixel Library.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_SERVER___

// Imports for Sandboxed Javascript.
const claimRequest = require('claimRequest');
const returnResponse = require('returnResponse');
const getRemoteAddress = require('getRemoteAddress');
const getRequestHeader = require('getRequestHeader');
const getRequestMethod = require('getRequestMethod');
const getRequestBody = require('getRequestBody');
const getRequestQueryParameters = require('getRequestQueryParameters');
const getRequestPath = require('getRequestPath');
const setPixelResponse = require('setPixelResponse');
const runContainer = require('runContainer');
const logToConsole = require('logToConsole');
const makeInteger = require('makeInteger');
const JSON = require('JSON');

const requestPath = getRequestPath();

// Processing unit for Phase 1 events fired from fbevents.js
if(requestPath === '/tr') {
  let params;

  if(getRequestMethod() == 'POST'){
    params = JSON.parse(getRequestBody());
  } else{
    params = getRequestQueryParameters();
  }

  logToConsole('Processing /tr event. Request:' + JSON.stringify(params));

  claimRequest();
  const eventModel = {};
  eventModel.event_name = params.ev;
  eventModel.event_time = makeInteger(params.ts/1000);
  eventModel.event_id = params.eid;
  eventModel.page_location = params.dl;
  if(params.test_event_code) eventModel.test_event_code = params.test_event_code;

  // Based on GTM common event data parameters -- https://developers.google.com/tag-manager/serverside/common-event-data
  eventModel.ip_override = getRemoteAddress();
  eventModel.user_agent = getRequestHeader('user-agent');


  // Mapping Facebook specific cookies
  if(params.fbp) eventModel['x-fb-ck-fbp'] = params.fbp;
  if(params.fbc) eventModel['x-fb-ck-fbc'] = params.fbc;

  // Mapping Facebook AAM parameters as customer information parameters.
  // For more details on Advanced matching parameters : https://developers.facebook.com/docs/facebook-pixel/advanced/advanced-matching/
  if(params['ud[em]']) eventModel['x-fb-ud-em'] = params['ud[em]'];
  if(params['ud[ph]']) eventModel['x-fb-ud-ph'] = params['ud[ph]'];
  if(params['ud[fn]']) eventModel['x-fb-ud-fn'] = params['ud[fn]'];
  if(params['ud[ln]']) eventModel['x-fb-ud-ln'] = params['ud[ln]'];
  if(params['ud[ge]']) eventModel['x-fb-ud-ge'] = params['ud[ge]'];
  if(params['ud[db]']) eventModel['x-fb-ud-db'] = params['ud[db]'];
  if(params['ud[ct]']) eventModel['x-fb-ud-ct'] = params['ud[ct]'];
  if(params['ud[st]']) eventModel['x-fb-ud-st'] = params['ud[st]'];
  if(params['ud[zp]']) eventModel['x-fb-ud-zp'] = params['ud[zp]'];
  if(params['ud[cn]']) eventModel['x-fb-ud-country'] = params['ud[cn]'];
  if(params['ud[external_id]']) eventModel['x-fb-ud-external_id'] = params['ud[external_id]'];
  if(params['cd[subscription_id]']) eventModel['x-fb-ud-subscription_id'] = params['cd[subscription_id]'];

  // Mapping custom data parameters
  if(params['cd[value]']) eventModel.value = params['cd[value]'];
  if(params['cd[currency]']) eventModel.currency = params['cd[currency]'];
  if(params['cd[search_string]']) eventModel.search_term = params['cd[search_string]'];

  if(params['cd[content_category]']) eventModel['x-fb-cd-content_category'] = params['cd[content_category]'];
  if(params['cd[content_ids]']) eventModel['x-fb-cd-content_ids'] = params['cd[content_ids]'];
  if(params['cd[content_name]']) eventModel['x-fb-cd-content_name'] = params['cd[content_name]'];
  if(params['cd[content_type]']) eventModel['x-fb-cd-content_type'] = params['cd[content_type]'];
  if(params['cd[contents]']) eventModel['x-fb-cd-contents'] = params['cd[contents]'];
  if(params['cd[num_items]']) eventModel['x-fb-cd-num_items'] = params['cd[num_items]'];
  if(params['cd[predicted_ltv]']) eventModel['x-fb-cd-predicted_ltv'] = params['cd[predicted_ltv]'];
  if(params['cd[status]']) eventModel['x-fb-cd-status'] = params['cd[status]'];
  if(params['cd[delivery_category]']) eventModel['x-fb-cd-delivery_category'] = params['cd[delivery_category]'];


  // Starts the  container to run the tag.
  runContainer(eventModel, () => {
    // on success callback sends standard response.
    setPixelResponse();
    returnResponse();
  });

  logToConsole('Processed /tr event!');
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "return_response",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_response",
        "versionId": "1"
      },
      "param": [
        {
          "key": "writeResponseAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "writeHeaderAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "run_container",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: On /tr request, Client runs container and generates eventModel tr fields mapped
  code: |-
    // Act
    runCode(mockConfigurationData);

    // Assert
    assertThat(actualEventModel).isEqualTo(expectedEventModel);
    assertApi('getRemoteAddress').wasCalled();
    assertApi('claimRequest').wasCalled();
    assertApi('getRequestHeader').wasCalledWith('user-agent');
    assertApi('getRequestPath').wasCalled();
    assertApi('getRequestQueryParameters').wasCalled();
    assertApi('setPixelResponse').wasCalled();
    assertApi('returnResponse').wasCalled();
- name: On Http Post requset, Client processes the request body and generates eventModel
  code: |-
    mock('getRequestMethod', () => {
      return 'POST';
    });

    mock('getRequestBody', () => {
      return JSON.stringify(testTrackingRequest);
    });

    // Act
    runCode(mockConfigurationData);

    // Assert
    assertThat(actualEventModel).isEqualTo(expectedEventModel);
    assertApi('getRequestMethod').wasCalled();
- name: On /collect request, Facebook Client does not claim Request
  code: |-
    mock('getRequestPath', () => {
      return '/collect';
    });

    // Act
    runCode(mockConfigurationData);

    // Assert
    assertApi('claimRequest').wasNotCalled();
    assertApi('runContainer').wasNotCalled();
- name: On Non-matching route request, Facebook Client does not claim Request
  code: |-
    mock('getRequestPath', () => {
      return '/non-matching-route';
    });

    // Act
    runCode(mockConfigurationData);

    // Assert
    assertApi('claimRequest').wasNotCalled();
    assertApi('runContainer').wasNotCalled();
setup: |-
  // Arrange
  const makeInteger = require('makeInteger');
  const JSON = require('JSON');

  const mockConfigurationData = {
    'config': 'value'
  };

  const testData = {
    event_name : 'test_event_name',
    time_stamp : 123456789,
    event_id : '1234',
    dl: 'www.example.com/foo.html',
    ip_address : '1.2.3.4',
    user_agent : 'test_browser_agent',
    email : 'foo@bar.com',
    phone_number: '123',
    first_name: 'foo',
    last_name: 'bar',
    gender: 'm',
    date_of_birth: '19910526',
    city: 'menlopark',
    state: 'ca',
    zip: '12345',
    country: 'us',
    external_id: 'user123',
    subscription_id: 'abc123',
    currency: 'usd',
    value: '123',
    content_category: 'product',
    content_ids: ['ABC123', 'XYZ789'],
    content_name: 'SampleItem',
    content_type: 'product',
    contents: [{'id': 'ABC123', 'quantity': 2}, {'id': 'XYZ789', 'quantity': 2}],
    num_items: 4,
    predicted_ltv: 101,
    search_string: 'query',
    status: 'subscribed',
    delivery_category: 'in_store',
    test_event_code: '123',
  };

  const testTrackingRequest = {
    ev: testData.event_name,
    ts: testData.time_stamp,
    eid: testData.event_id,
    test_event_code: testData.test_event_code,
    dl: testData.dl,
    'ud[em]' : testData.email,
    'ud[ph]' : testData.phone_number,
    'ud[fn]' : testData.first_name,
    'ud[ln]' : testData.last_name,
    'ud[ge]' : testData.gender,
    'ud[db]' : testData.date_of_birth,
    'ud[ct]' : testData.city,
    'ud[st]' : testData.state,
    'ud[zp]' : testData.zip,
    'ud[cn]' : testData.country,
    'ud[external_id]' : testData.external_id,
    'cd[currency]' : testData.currency,
    'cd[value]' : testData.value,
    'cd[content_category]' : testData.content_category,
    'cd[content_ids]' : testData.content_ids,
    'cd[content_name]' : testData.content_name,
    'cd[content_type]' : testData.content_type,
    'cd[contents]' : testData.contents,
    'cd[num_items]' : testData.num_items,
    'cd[predicted_ltv]' : testData.predicted_ltv,
    'cd[search_string]' : testData.search_string,
    'cd[status]' : testData.status,
    'cd[delivery_category]' : testData.delivery_category,
    'cd[subscription_id]' : testData.subscription_id,
  };

  const expectedEventModel = {
    'event_name': testData.event_name,
    'event_time': makeInteger(testData.time_stamp/1000),
    'event_id': testData.event_id,
    'page_location': testData.dl,
    'ip_override': testData.ip_address,
    'user_agent': testData.user_agent,
    'test_event_code': testData.test_event_code,

    // user data section
    'x-fb-ud-em': testData.email,
    'x-fb-ud-ph': testData.phone_number,
    'x-fb-ud-ln': testData.last_name,
    'x-fb-ud-fn': testData.first_name,
    'x-fb-ud-ge': testData.gender,
    'x-fb-ud-db': testData.date_of_birth,
    'x-fb-ud-ct': testData.city,
    'x-fb-ud-st': testData.state,
    'x-fb-ud-zp': testData.zip,
    'x-fb-ud-country': testData.country,
    'x-fb-ud-external_id': testData.external_id,
    'x-fb-ud-subscription_id': testData.subscription_id,

    // common custom data fields that are defined already
    'currency': testData.currency,
    'value': testData.value,
    'search_term': testData.search_string,

    // Fields that don't have a mapping already will be defined as fb specific.
    'x-fb-cd-content_category': testData.content_category,
    'x-fb-cd-content_ids': testData.content_ids,
    'x-fb-cd-content_name': testData.content_name,
    'x-fb-cd-content_type': testData.content_type,
    'x-fb-cd-contents': testData.contents,
    'x-fb-cd-num_items': testData.num_items,
    'x-fb-cd-predicted_ltv': testData.predicted_ltv,
    'x-fb-cd-status': testData.status,
    'x-fb-cd-delivery_category': testData.delivery_category,
  };

  mock('getRequestPath', () => {
    return '/tr';
  });

  mock('getRemoteAddress', () => {
    return testData.ip_address;
  });

  mock('getRequestHeader', header => {
    if(header === 'user-agent') return testData.user_agent;
  });

  mock('getRequestPath', () => {
    return '/tr';
  });

  mock('getRequestQueryParameters', () => {
    return testTrackingRequest;
  });

  mock('claimRequest', () => {
    return {};
  });

  mock('setPixelResponse');
  mock('returnResponse');
  mock('claimRequest');


  let actualEventModel;
  mock('runContainer', (calledEventModel, onComplete) => {
      actualEventModel = calledEventModel;
      onComplete();
    });


___NOTES___

Created on 8/5/2020, 10:20:28 AM
