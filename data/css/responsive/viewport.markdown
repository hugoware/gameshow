# Using `Viewport`

A `viewport` is crucial to responsive design by allowing you to define the `window` your site should be viewed at.

![](/resources/css/viewport.png)

_Without a viewport, the iPhone scales the previous example to fit on its screen._


#///

# Why `viewport`?

When smartphones were introduced, a lot of websites were designed for large screens (desktops, laptops, etc). Mobile browsers had to zoom in an out ot view content.

The `viewport` was created to allow a browser to define the viewing area for a page.


#///

# Including a Viewport

The most basic way to use `viewport` is the following...

[code:html]
<meta name="viewport" content="width=device-width, initial-scale=1">
[/code]

Essentially, this tag is telling the browser that it can expect the site to look correct at it's current width. The `initial-scale` is used to make certain that `1px` is `1px` _(probably for high density displays, etc)_


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