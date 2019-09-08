# Autocomplete (using fetch) for Cockpit CMS

Use an external API as a field data source.

## Installation
Install Cockpit CMS addon by extracting to the addons folder (/addons/FetchAutocomplete)

## Usage
Field Options:
- `url` - Data source (required) 
- `param` - Parameter used for search query (default: `search`)
- `root` - JSON array element root (Default: JSON root element)
- `value` - Element name of value (Default: `value`)
- `title` - Element name of title (Default: `title`)
- `limit` - Limit parameter (Default: `limit`)

## Example:

Endpoint:

`https://www.example.com/api?q=searchterm`

JSON Response:
```
{
    "products": [
        {
            "name": "Product Name 1",
            "sku": "ABCXYZ001" 
        },
        {
            "name": "Product Name 2",
            "sku": "ABCXYZ002" 
        }
    ]
}
```

Options:

```
{
  "url": "https://www.example.com/api",
  "param": "q",
  "root": "products",
  "value": "sku",
  "title": "name"
}
```

## Copyright and license

Copyright 2019 Heavy Craft LLC under the MIT license.