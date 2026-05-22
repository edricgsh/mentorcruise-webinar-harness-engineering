#!/usr/bin/env bun
// validate.ts — run with: bun .claude/skills/cleanup/scripts/validate.ts

import { existsSync, readFileSync } from "fs";

const skillPath = new URL("../SKILL.md", import.meta.url).pathname;
if (!existsSync(skillPath)) {
  console.error("ERROR: SKILL.md not found");
  process.exit(1);
}

const content = readFileSync(skillPath, "utf-8");
const hasFrontmatter = content.startsWith("---");
const hasName = /^name:\s+\S/m.test(content);
const hasDescription = /^description:/m.test(content);
const hasAllowedTools = /^allowed-tools:/m.test(content);
const hasSteps = /^## Steps/m.test(content);
const hasErrorHandling = /^## Error Handling/m.test(content);

const checks = [
  [hasFrontmatter, "Has frontmatter block"],
  [hasName, "Has name field"],
  [hasDescription, "Has description field"],
  [hasAllowedTools, "Has allowed-tools field"],
  [hasSteps, "Has Steps section"],
  [hasErrorHandling, "Has Error Handling section"],
];

let allPassed = true;
for (const [passed, label] of checks) {
  console.log(`${passed ? "✅" : "❌"} ${label}`);
  if (!passed) allPassed = false;
}

if (!allPassed) {
  console.error("\nERROR: SKILL.md missing required fields");
  process.exit(1);
}

console.log("\nOK: SKILL.md structure is valid");
