# Preprocessors

**Preprocessors** are the closest thing to a CSS programming language available. A preprocessor is a language similar to CSS that can be _converted into actual CSS_.

**SASS** is a very popular CSS preprocessor. Additionally, **LESS** is a similar .NET alternative.



#///

# Syntax

SASS looks a lot like CSS, but without a lot of the extra characters. Not only that, SASS allows you to nest `selectors` within each other, which can help improve the readability of your stylesheet.

[code:sass]
.profile
  background: #eee

  .name
    font-weight: bold
    font-size: 30px

  .avatar
    height: 30px
    width: 30px
[/code]



#///

# Variables

SASS also allows you to **define variables** that can be used through the stylesheet. You can even use these variables in some operations

[code:sass]
$icon-size: 100px

.avatar
  height: $icon-size
  width: $icon-size
  margin-left: $icon-size * .25
[/code]




#///

# Mixins

Mixins are essentially `functions` in CSS. They allow you to pass in arguments and return back results. SASS also comes with a variety of built in functions.

[code:sass]
@mixin resize( $size )
  height: $size
  width: $size

.avatar
  +resize( 100px )
  background: darken( #border-color, 50% )
[/code]



#///

# Output

It's important to remember that all code, functions, mixins, etc, are all executed when your SASS is converted into CSS. After the process is finished, it's just regular CSS again.

[code:css]
.avatar {
  height: 100px;
  width: 100px;
  margin-left: 25px; }
[/code]



#///

# So Much More!

This is a tiny example of some of the things you can do with a preprocessor. Realistically speaking, preprocessors like **SASS** and **LESS** require an entire talk of their own.

