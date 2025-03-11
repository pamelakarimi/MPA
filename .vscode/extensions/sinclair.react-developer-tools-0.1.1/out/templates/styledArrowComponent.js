"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = (componentName) => {
    return `import React from 'react';
import { Wrapper } from './styled';

interface Props {
}

const ${componentName} = (props: Props) => {
    return <Wrapper></Wrapper>;
};

export default ${componentName};
`;
};
//# sourceMappingURL=styledArrowComponent.js.map