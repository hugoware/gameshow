# Specificity

At first glance, CSS appears to apply rules based on the order rules are found in their respective stylesheets.

In all actuality, CSS uses a number of criteria to determine the order rules are applied.


#///

# Using Classes

When compared to an `element` selector, a `class` name is considered more specific and takes priority.

[code:html]
<span id="label" class="label" > Hello, World! </span>

<style type="text/css" >
  .label { color: green; } /* winner */
  span { color: blue; }
</style>
[/code]



#///

# Using IDs

`IDs` are considered extremely specific and are more difficult to override...

[code:html]
<span id="label" class="label" > Hello, World! </span>

<style type="text/css" >
  #label { color: blue; } /* winner */
  .label { color: green; }
  span { color: red; }
</style>
[/code]



#///

# Using `!important`

The `!important` attribute property is essentially the trump card when it comes to specificity.

[code:html]
<span id="label" class="label" > Hello, World! </span>

<style type="text/css" >
  #label { color: blue; }
  .label { color: green; }
  span { color: red !important; } /* winner */
</style>
[/code]

This will cause a `declaration` to take priority over all others except...



#///

# Using `!important`

... other `!important` attribute properties...

When this happens, both rules are evaluated using their original selector specificity values.

[code:html]
<span id="label" class="label" > Hello, World! </span>

<style type="text/css" >
  #label { color: blue !important; } /* winner */
  .label { color: green; }
  span { color: red !important; }
</style>
[/code]

_This is why it's a bad idea to use `!important` unless you really need to._

