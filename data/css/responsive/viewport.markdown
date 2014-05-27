# Using `Viewport`

A `viewport` is crucial to responsive design by allowing you to define the `window` your site should be viewed at.

![](/resources/css/viewport.png)

_Without a viewport, the iPhone scales the previous example to fit on its screen._


#///

# Including a Viewport

[code:html]
<meta name="viewport" content="initial-scale=1" >
[/code]



#///

# More Mobile

There are additional `meta` and other tags that can be used to further define the mobile experience for a site.

[code:html]
<!-- the title if added to the home screen -->
<meta name="apple-mobile-web-app-title" content="My App">

<!-- turn off phone number links. -->
<meta name="format-detection" content="telephone=no">

<!-- make the status bar black -->
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<!-- home screen icons -->
<link rel="apple-touch-icon" href="http://site.com/icon.png" />
<link rel="apple-touch-icon-precomposed" href="http://site.com/icon.png" />

<!-- prevent automatic text resizing. -->
<style>html { -webkit-text-size-adjust: 100%; }</style>
[/code]