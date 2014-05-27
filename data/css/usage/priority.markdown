# CSS Priority

Not all CSS is equal in importance and some CSS rules will override each other.


#///

# Priority Has An Order

CSS rules are overwritten if a `declaration` is found in a rule with a higher priority.

1. User defined
2. Inline
3. Media Type
4. Importance
5. Selector specificity
6. Rule order
7. Parent inheritance
8. CSS property definition in HTML document
9. Browser default


#///

# Avoid: Inline Styles

The `style` attribute has a very high priority, which makes if difficult in some cases to override the value.



#///

# Avoid: `!important`

The `!important` attribute property also has a very high priority.

It's tempting to use this when you have CSS that isn't cooperating, but ultimately it will make your CSS more difficult to maintain.