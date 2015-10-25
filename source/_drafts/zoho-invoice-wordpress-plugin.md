title: Zoho Invoice Wordpress Plugin
id: 552
categories:
  - Software
date: 2012-11-13 18:44:42
tags:
---

Our latest project has been getting our invoicing software, Zoho Invoice, up and running for clients to view past invoices and current pending invoices from inside their user account. In doing so, we've decided to migrate our code to a plugin for everyone to use (for free of course).

You can download the plugin [here](http://wordpress.org/extend/plugins/zoho-invoice/ "Zoho Invoice Plugin").

### Usage

The plugin is designed to execute via shortcodes. Once you've added your API key and Auth token in settings, you can add shortcodes to any posts or pages.
`[ listcustomers]`
The above shortcode will generate a list of your customers complemented by their customer ID.
`[ invoice customer="000000000000000000"]`
Intended for the customer to view, this shows a complete list of invoices for the specified customer. The _customer_ tag refers to the 18 character CustomerID.