title: Zoho Invoice Wordpress Plugin
categories:
  - software
date: 2012-11-13 18:44:42
tags:
---

My latest project has been getting our invoicing software, Zoho Invoice, up and running for clients to view past 
invoices and current pending invoices from inside their user account. In keeping all things modular, I've written it as a plugin for WP and have pushed the source to the WP market. 

<!-- more -->

You can download the plugin [here](http://wordpress.org/extend/plugins/zoho-invoice/ "Zoho Invoice Plugin").

### Usage

The plugin is designed to execute via shortcodes. Once you've added your API key and Auth token in settings, you can add shortcodes to any posts or pages.
`[ listcustomers]`
The above shortcode will generate a list of your customers complemented by their customer ID.
`[ invoice customer="000000000000000000"]`
Intended for the customer to view, this shows a complete list of invoices for the specified customer. The _customer_ tag refers to the 18 character CustomerID.