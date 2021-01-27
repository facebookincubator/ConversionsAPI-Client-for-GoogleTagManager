# Facebook's Conversions API for Google Tag Manager(server-side)

The Conversions API allows advertisers to send web events from their servers directly to Facebook. Server events are linked to a pixel and are processed like browser pixel events. This means that server events are used in measurement, reporting, and optimization in the same way as browser pixel events. [Learn More](https://developers.facebook.com/docs/marketing-api/conversions-api).

Google Tag Manager(GTM) have released support for their [server-side](https://developers.google.com/tag-manager/serverside/) support for sharing customer actions with analytics partners directly from Advertisers' servers. This repository contains the Templates(Client and Tag) that advertisers can install on their GTM's Tagging server and send to Facebook's Conversions API.

This template is a server-side client that can be deployed on a tagging server to listen to events from advertisers' websites and run various tags on the events it receives.

(This feature may not be available to you. Contact your Facebook representative for more details.)

# Installation

<ol>
<li>Log into your Google Tag Manager server side container where you want to use the template.</li>
<li>From the Workspace tab, select Templates from the left-hand menu.</li>
<li>Click the New button in the Client templates section.</li>
<li>On the Template Editor page, click the 3 dots in the upper right and select Import</li>
  <li>Navigate to your local copy of the template.tpl file and add it to your workspace.</li>
</ol>

# Reporting Bugs/Feedback
Please raise any issue on GitHub

# License
ConversionsAPI-Client-for-GoogleTagManager is licensed under LICENSE file in the root directory of this source tree.
