# Including CSS

CSS can be included in a page using several different methods

* `style` Attribute
* `STYLE` Element
* `LINK` Element



#///
# `STYLE` Attribute

Using a `style` attribute, you can write `declarations` directly onto an element. *This is not recommended unless you have a specific reason*.

[code:html]
<h1 style="color:red" >
  Hello, World!
</h1>
[/code]




#///
# `STYLE` Element

A `style` element allows you to define multiple rules within the same element. It's similar to a `stylesheet`, but embedded in the page.

[code:html]
<style type="text/css" >
  h1 { color: #f00; }
</style>
[/code]




#///

# `LINK` Element

The `link` element is used to include external CSS files in a page. *This is the recommended approach*.

[code:html]
<!-- rel and type attributes are important -->
<link rel="stylesheet"
      type="text/css"
      href="/ui/styles.css" />
[/code]