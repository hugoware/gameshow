# CSS Minification

As with all content served over the web, users must download resources to their browser before they can be used.

Like with JavaScript, minification can be used to reduce the size of a CSS file, and in turn, speed up the time that it takes for a page to load.


#///

# Basic Minification

By simply removing whitespace and new lines, a CSS file can be greatly reduced in size.

[code:css]
h1 {
  color: #ff0000;
  font-weight: bold;
}
ul > li {
  color: #440044;
}
[/code]



#///

# Basic Minification

Minification reduced this example from **0.075KB** to **0.049KB**

[code:css]
h1{color:red;font-weight:700}
ul > li{color:#404}
[/code]


#///

# Optimizations

Not only that, but some minfiers will identify certain shorter ways to write CSS, reducing your file by a little bit more.

In the previous example, the following values were changed

* `#FF0000` to `red`
* `#440044` to `#404`
* `bold` to `700`

It's a small change, but it'll add up the larger your file gets.


#///

# Concatination

Merging all of your CSS files together is another way to reduce network traffic. Each request for an external file takes time and it begins to add up.

Using file concatination with minification can lead to notable time savings.