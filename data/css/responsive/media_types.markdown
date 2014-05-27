# Media Types

The `media` attribute has been available for `link` elements as a means to provide a different stylesheet depending on device.



#///

# Media Types

There are many media types already supported by the `media` attribute. Some are used far more oten than others.

1. screen
1. print
1. handheld
1. projection
1. tv
1. aural
1. braille
1. embossed
1. tty



#///

# An Example

In some cases, you might want to have a printer friendly version of a page. My specifying the media type, the browser knows to switch to the other stylesheet when printing.

[code:html]
<link type="text/css" rel="stylesheet" href="style.css" >
<link type="text/css" rel="stylesheet" href="print.css" media="print">
[/code]

![](/resources/css/print.png)

