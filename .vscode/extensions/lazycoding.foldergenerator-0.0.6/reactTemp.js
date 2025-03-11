const reactTemp = (name) => {
  return `
import React from 'react';
import Styles from "./${name}.module.scss"

const ${name} = () => {
    return (
      <div>
          ${name}
      </div>
    );
}

export default ${name}`.trimStart();
};

const reactTsxTemp = (name) => {
  return `
import React from 'react';
import Styles from "./${name}.module.scss"

interface Props {
}

const ${name} = (props: Props): JSX.Element => {
    return (
      <div>
          ${name}
      </div>
    );
}

export default ${name}`.trimStart();
};
module.exports = {
  reactTemp,
  reactTsxTemp
};
