# Media Queries

A media query is a new CSS3 feature that allows for rules to change depending on criteria normally defined by the device being used.


#///

# An Example

The most common example is a regular website along with the mobile version of the site.

![](/resources/css/responsive-example.png)



#///

# For Layout

One of the most common examples of a media query to to rearrange a layout depending on the width of a device. The example below changes layout when the `viewport` reaches `600px` or less

[code:css]
.content {
  width: 33.3%;
  float: left;
  background: #f00;
}

/* smaller screens */
@media (max-width: 600px) {
  .content {
    float: none;
    width: auto;
    background: #00f;
  }
}
[/code]



#///

# For Layout

When resized to `600px` or less, the layout changes from the red blocks to the blue blocks.

![](/resources/css/responsive.png)