module.exports = {
  'packages/**/*.{ts,tsx}': (files) =>
    `nx affected -t lint:type --files=${files.join(',')}`,
  'packages/**/*.{js,ts,jsx,tsx,json}': (files) =>
    `nx affected:lint --fix --files=${files.join(',')}`,
  'packages/**/*.{tf}': (files) => files.map((file) => `terraform fmt ${file}`),
  '**/*.{js,ts,jsx,tsx,json,cjs,html,css}': (files) =>
    `nx format:write --files=${files.join(',')}`,
};
