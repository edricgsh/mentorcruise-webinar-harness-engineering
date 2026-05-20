---
theme: seriph
background: https://cover.sli.dev
title: AI Coding That Actually Works
class: text-center
drawings:
  persist: false
transition: slide-left
comark: true
duration: 35min
---

# AI Coding That Actually Works

From frustration to flow — it's about the harness

<div class="abs-br m-6 text-xl opacity-50 text-sm">MentorCruise Webinar · 2026</div>

---
layout: center
class: text-center
---

# Why do some people hate AI-generated code...

<v-click>

## ...and others can't live without it?

</v-click>

<v-click>

<div class="mt-8 text-2xl opacity-70">Same tool. Different results.</div>

</v-click>

---
layout: center
---

# The real variable: **Context**

<div class="grid grid-cols-2 gap-12 mt-8 text-left">
<div v-click>

### What AI sees
- Your prompt
- The conversation history
- Loaded files & skills
- System instructions

</div>
<div v-click>

### What AI doesn't see
- What you tried 3 messages ago
- The file you forgot to open
- The constraint you assumed was obvious

</div>
</div>

---
layout: center
class: text-center
---

<div class="text-6xl font-bold mb-4">Garbage in</div>
<div class="text-4xl opacity-50">garbage out</div>

<v-click>
<div class="mt-12 text-2xl">AI doesn't know what you know.</div>
<div class="text-xl opacity-60 mt-2">It only works with what's in the window.</div>
</v-click>

---

# The Other Half: Harness

<div class="text-xl opacity-70 mb-8">How do you let AI validate its own output?</div>

<div class="grid grid-cols-3 gap-6 mt-4">

<div v-click class="p-4 rounded border border-white/20">
  <div class="text-2xl mb-2">🪵</div>
  <div class="font-bold">Log inspection</div>
  <div class="text-sm opacity-60 mt-1">AI reads what the app actually did</div>
</div>

<div v-click class="p-4 rounded border border-white/20">
  <div class="text-2xl mb-2">🗄️</div>
  <div class="font-bold">Database checking</div>
  <div class="text-sm opacity-60 mt-1">Verify data, not just code</div>
</div>

<div v-click class="p-4 rounded border border-white/20">
  <div class="text-2xl mb-2">🧪</div>
  <div class="font-bold">API testing</div>
  <div class="text-sm opacity-60 mt-1">AI runs the tests itself</div>
</div>

</div>

<v-click>
<div class="mt-10 text-center text-xl">
A good harness = AI that catches its own mistakes
</div>
</v-click>

---
layout: center
class: text-center
---

# Part 1

<div class="text-4xl font-bold mt-4">Context is Everything</div>

---

# What goes into every AI conversation?

<div class="grid grid-cols-2 gap-8 mt-6">

<div>

<v-click>

**System prompt**
- Theme, instructions, skills
- Can be hundreds of lines long
- You probably haven't read it

</v-click>

<v-click>

**Conversation history**
- Every message back and forth
- Gets compressed as it grows
- Old context fades away

</v-click>

</div>

<div>

<v-click>

**Loaded context**
- Files you've read
- Tools that were called
- Agent sub-results

</v-click>

<v-click>

**Skills / MCP tools**
- Each adds to the system prompt
- Too many = noise
- Install selectively

</v-click>

</div>
</div>

---

# Tips to Preserve Context

<div class="space-y-6 mt-4">

<div v-click class="flex gap-4 items-start">
  <div class="text-2xl">🤖</div>
  <div>
    <div class="font-bold">Use subagents for isolated work</div>
    <div class="text-sm opacity-60">Keeps the main thread clean — subagents don't pollute your context</div>
  </div>
</div>

<div v-click class="flex gap-4 items-start">
  <div class="text-2xl">🧱</div>
  <div>
    <div class="font-bold">Caveman plugin</div>
    <div class="text-sm opacity-60">Forces structured, explicit context on every prompt</div>
  </div>
</div>

<div v-click class="flex gap-4 items-start">
  <div class="text-2xl">📦</div>
  <div>
    <div class="font-bold">Load skills intentionally</div>
    <div class="text-sm opacity-60"><code>npx skills</code> · Don't install everything you find — add as you need</div>
  </div>
</div>

<div v-click class="flex gap-4 items-start">
  <div class="text-2xl">📊</div>
  <div>
    <div class="font-bold">Status line in Claude Code</div>
    <div class="text-sm opacity-60">See token usage in real time — know when you're running out of runway</div>
  </div>
</div>

</div>

---
layout: center
class: text-center
---

# Demo

<div class="text-2xl opacity-60 mt-4">Understanding your system prompt</div>

<div class="mt-8 text-lg opacity-40">What's Claude actually seeing right now?</div>

---
layout: center
class: text-center
---

# Part 2

<div class="text-4xl font-bold mt-4">Building a Basic Harness</div>

---

# The Harness Setup

<div class="text-lg opacity-60 mb-6">An environment where AI can write code <em>and</em> verify it</div>

<div class="grid grid-cols-3 gap-6">

<div v-click class="p-5 rounded-lg border border-white/20 text-center">
  <div class="text-3xl mb-3">🪵</div>
  <div class="font-bold text-lg">Log Inspector</div>
  <div class="text-sm opacity-50 mt-2">AI reads app logs to confirm behavior</div>
  <div class="mt-3 font-mono text-xs opacity-40">skill: log-tail</div>
</div>

<div v-click class="p-5 rounded-lg border border-white/20 text-center">
  <div class="text-3xl mb-3">🗄️</div>
  <div class="font-bold text-lg">DB Inspector</div>
  <div class="text-sm opacity-50 mt-2">Query local SQLite to verify data</div>
  <div class="mt-3 font-mono text-xs opacity-40">skill: sqlite-inspector</div>
</div>

<div v-click class="p-5 rounded-lg border border-white/20 text-center">
  <div class="text-3xl mb-3">🧪</div>
  <div class="font-bold text-lg">API Tester</div>
  <div class="text-sm opacity-50 mt-2">AI runs endpoint tests itself</div>
  <div class="mt-3 font-mono text-xs opacity-40">skill: api-test</div>
</div>

</div>

<v-click>
<div class="mt-8 text-center text-xl">
  AI writes → AI runs → AI reads → AI fixes
</div>
</v-click>

---
layout: center
class: text-center
---

# Demo

<div class="text-2xl opacity-60 mt-4">Two projects, live harness</div>

<div class="mt-8 space-y-2 text-left inline-block">
  <div class="text-sm opacity-40">→ Backend + Frontend running</div>
  <div class="text-sm opacity-40">→ AI inspects logs</div>
  <div class="text-sm opacity-40">→ AI checks the database</div>
  <div class="text-sm opacity-40">→ AI runs API tests</div>
  <div class="text-sm opacity-40">→ AI fixes what it broke</div>
</div>

---
layout: center
class: text-center
---

# The takeaway

<v-click>
<div class="text-3xl font-bold mt-6">Context + Harness</div>
</v-click>

<v-click>
<div class="text-xl opacity-60 mt-4">Give AI a clear picture of what to do.</div>
<div class="text-xl opacity-60">Give it the tools to know if it worked.</div>
</v-click>

<v-click>
<div class="mt-10 text-4xl">That's it.</div>
</v-click>

---
layout: center
class: text-center
---

# Questions?

<div class="mt-6 opacity-40 text-sm">MentorCruise Webinar · 2026</div>
