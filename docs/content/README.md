# Common Block Structure

-  `type`- block type, required, `String`.
-  `data`- block body, required, `Map<String, dynamic>`.   
- `compat`- the block that will be displayed if a old version is used, optional, `Map<String, dynamic>`.


## Heading Block Structure

 - `type`: `heading`
 - `data`
    - `text` - heading content, required, `String`.
    - `level` - heading level from 1 to 3, required, `int`. 

## Paragraph Block Structure

 - `type`: `paragraph`
 - `data`
    - `children` - paragraph text units with its own styles, required, `List<Map<String, dynamic>>`. Each paragraph item is a `Map<String, dynamic>` with the following fields:
        - `text` - content of the paragraph item, required, `String`.
        - `style` - style of the paragraph item, required, `Map<String, bool>`.
            - `is_bold`
            - `is_italic`
            - `is_monospaced`

## List Block Structure

- `type`: `list`
- `data`
    - `type` - the type of list that is converted to an enumeration variant, required, `String`. Can take the value `ORDERED` or `BULLETED`.
    - `items` - items of the list, required, List<Map<String, dynamic>>. Each item corresponds to the value of the "data" field of the [paragraph](#paragraph-block-structure).


## Video Block Structure

- `type`: `video`
- `data`
     - `url` - video URL, required, `String`.

## Image Block Structure

- `type`: `image`
- `data`
     - `url` - image URL, required, `String`.
