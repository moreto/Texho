import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
import json from "@eslint/json";
import { defineConfig } from "eslint/config";


export default defineConfig([
  { files: ["**/*.{js,mjs,cjs,ts,mts,cts}"], plugins: { js }, extends: ["js/recommended"] },
  { files: ["**/*.{js,mjs,cjs,ts,mts,cts}"], languageOptions: { globals: globals.node } },
  {
    rules: {
      "no-useless-catch": "off",
      "max-len": ["error", { code: 120, ignoreComments: true, ignoreStrings: true, ignoreTemplateLiterals: true }],
    },
  },
  tseslint.configs.recommended,
  { files: ["**/*.json"], plugins: { json }, language: "json/json", extends: ["json/recommended"] },
]);
