# Pseudo Selectors

Pseudo Selectors are special keywords that are used to select elements when they are in a certian state.

This can be in response to a user interaction, position on the page, input status, and more.


#///

# `:hover` Selector

This selector matches when an element is hovered over. Unlike most selectors, it requires user interaction to cause this selector to become valid.

[code:css]
a { text-decoration: none; }
a:hover { text-decoration: underline; }
[/code]

Selectors like `:active`, `:visited`, and `:link` are common in many stylesheets.


#///

# `:before` and `:after`

These are very unique elements that allow you to select just before and after an element. This, coupled with the `content` property, allows you to accomplish some

[code:css]
.navigate:after {
  content: ' >>>'
  color: #f00;
}
[/code]

![](/resources/css/navigate.png)



#///

# Child Pseudo Selectors

You can also use pseudo selectors to select elements using their index or position relative to their parent.

[code:css]
ul > li:first-child {
  font-weight: bold;
  font-size: 18px
}
[/code]

