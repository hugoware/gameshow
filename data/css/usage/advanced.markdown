# Declaration Shorthand

Many CSS declarations have shorthand versions that allow multiple values to be set at once.

[code:css]
div {
  border-width: 1px;
  border-style: solid;
  border-color: red;
}

div {
  border : 1px solid red;
}
[/code]


#///

# More Shorthand

Many CSS declarations have shorthand versions that allow multiple values to be set at once.

[code:css]
div {
  margin: 0; /* margin-left, margin-right, etc */
  padding: 0; /* padding-left, padding-right, etc */
  font: bold 32px sans-serif; /* font-weight, font-family, etc */
}



#///

# Accidential Overrides

Be careful when using shorthand since it will override missing values with it's own default values. For example, the border will disappear in this example.

[code:css]
div {
  border: 1px solid red;
}

/* elsewhere... */
div {
  border: 2px;
}



#///

# Applying Rules

Try a more specific declaration when trying to make a smaller change. This will prevent you from overriding too much.

[code:css]
div {
  margin: 25px;
}

div.label {
  margin-right: 50px;
}
[/code]