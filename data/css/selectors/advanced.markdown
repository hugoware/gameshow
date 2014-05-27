# More Selectors

Selecting elements by `id`, `class`, and `element`, is just one way to use selectors. There are a lot of other ways to match elements.


#///

# Multiple Selections

Use commas to use multiple selectors for the same rule set. This apply the declarations for both selectors.

[code:css]
button, .button, #submit {  }
[/code]

This will select all `button` elements, anything with the class `button` and anything with the ID `submit`.



#///

# Child Selector

Using the Child Selector, `>`, will limit matches to only elements that are contained directly within the previous match.

This is helpful when trying to avoid selecting too much.

[code:css]
/* all LI elements anywhere within a UL */
ul li {  }

/* only LI elements that are children of UL */
ul &gt; li {  }
[/code]



#///

# Attribute Selectors

Attribute selectors allow you to check for the value of `attributes` on elements. Support for this selector can be found as far back as *Internet Explorer 7*.

[code:css]
/* apply a rule to links that open a new window */
a[target="_blank"] {  }

/* apply a rule to elements that have a title set */
[title] {  }
[/code]
