# Selector Basics

A `Selector` is a pattern used to match elements so that the `rule set` applied can be applied.


#///

# Selector Targets

There are a lot of ways to select element, but here are some common methods.

* **By Element** - example `h1` or `div`
* **By ID** - example `#search` or `#name`
* **By Class** - example `.item` or `.icon`


#///

# Universal Selector

Additionally, you can use the Universal Selector, `*`, to select everything. It's generally a bad idea to use this.


#///

# Selector Examples

#### `div strong`
Selects all **strong** elements inside of any **div**

#### `#search input`
Selects all **input** elements inside of any element with the ID **search**

#### `form .label`
Selects all elements with a class **label** inside of any **form** element



#///

# More Selector Examples

#### `input#name`
Selects all **input** elements that also have the ID **name**

#### `span.item`
Selects all **span** elements that also have the class **item**

#### `span .item`
Selects all elements that have the class **item** inside of any **span** elements
