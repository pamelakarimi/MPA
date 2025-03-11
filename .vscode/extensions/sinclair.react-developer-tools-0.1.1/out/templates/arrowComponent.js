"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (componentName) => {
    return `import React from 'react';

interface Props {
}

const ${componentName} = (props: Props) => {
    return null;
};

export default ${componentName};
`;
};
//# sourceMappingURL=arrowComponent.js.map