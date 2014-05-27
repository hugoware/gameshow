# Font Stacks

As CSS Resets attempted to address that not all browsers are the same, a "font stack" deals with the problem that not all devices have the same fonts.



#///

# Font Stacks

A font stack is simply a list of fonts to fall back to in the event the first one is not available. Ideally, each font is more and more generic, but similar in appearance to the desired font.




#///

# In Action

The sample below shows a common font stack. If the first font is not available, then the next font on the list is used.

[code:css]
p {
  font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
}
[/code]

![](/resources/css/fontstack-example.png)




#///

# Choosing A Font Stack

There are many great resources available for creating a custom font stack that is exactly what your site needs.

![](/resources/css/fontstack-site.png)



#///

# Web Fonts

As an alternative, or along with, you can customize your fonts by using Web Fonts. You can host them on your own server, or use a service such as **Google Fonts**.

However, custom fonts requires more content to downloaded before your page will load (which is especially bad for mobile users). Not only that, sometimes users are greeted with...

![](/resources/css/webfont.png)