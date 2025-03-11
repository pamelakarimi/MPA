const propsRegex = /<([A-Z][a-zA-Z0-9.]*)\s+([^>]+?)\/?>/g;

const getProps = (component) => {
  let match;
  let props = {};

  while ((match = propsRegex.exec(component)) !== null) {
    const attributesString = match[2].trim();

    const attributeRegex =
      /(\w+)(={?(?:(?:"([^"]*)")|(?:'([^']*)')|(?:`([^`]*)`)|(\btrue\b|\bfalse\b)?)}?)?/g;

    let attributeMatch;

    while ((attributeMatch = attributeRegex.exec(attributesString)) !== null) {
      const attributeName = attributeMatch[1];
      const attributeValue = [...attributeMatch].reverse().find((e) => e);

      if (attributeValue === attributeName || attributeValue === "true")
        props[attributeName] = true;
      else if (attributeValue === "false") props[attributeName] = false;
      else props[attributeName] = attributeValue;
    }
  }

  return props;
};

module.exports = getProps;
