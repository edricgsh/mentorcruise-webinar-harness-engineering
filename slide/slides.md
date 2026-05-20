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

It's not the model. It's the setup.

<div class="abs-br m-6 opacity-40 text-sm">MentorCruise Webinar · 2026</div>

---
layout: center
class: text-center
---

# Why does AI write great code for some people...

## ...and garbage for others?

<div class="mt-8 text-xl opacity-60">Same model. Same tool. Wildly different results.</div>

---
layout: center
class: text-center
---

# Two things decide the outcome

<div class="grid grid-cols-2 gap-16 mt-10 text-left">
<div class="text-center">
  <div class="text-5xl mb-4">🧠</div>
  <div class="text-2xl font-bold">Context</div>
  <div class="mt-2 opacity-60">What AI knows going in</div>
</div>
<div class="text-center">
  <div class="text-5xl mb-4">🔧</div>
  <div class="text-2xl font-bold">Harness</div>
  <div class="mt-2 opacity-60">How it checks its own work</div>
</div>
</div>

---
layout: center
class: text-center
---

# Context

---

# What's actually in your AI's head right now?

<div class="grid grid-cols-2 gap-10 mt-6 text-left">
<div>

**The system prompt**
Everything the tool loaded before you typed anything — skills, settings, instructions. Probably hundreds of lines. You haven't read it.

**Your conversation history**
Every message back and forth. Gets compressed as it grows. Old context quietly disappears.

</div>
<div>

**Files you opened**
Only what you explicitly loaded. AI doesn't browse your repo on its own.

**Loaded skills / MCP tools**
Each one adds more to the system prompt. Install too many and it's noise.

</div>
</div>

---
layout: center
class: text-center
---

<div class="text-7xl font-bold">Garbage in,</div>
<div class="text-5xl opacity-40 mt-2">garbage out.</div>

<div class="mt-12 text-xl">AI doesn't know what you know. It only works with what's in the window.</div>

---

# The mistakes people make

<div class="space-y-6 mt-6 text-lg">

**Vague prompts with no file context**
"Fix the bug" — which bug? What file? What does it look like now?

**Letting context rot**
Long sessions compress old messages. The AI from message 50 isn't the same AI from message 5.

**Installing every skill they find online**
Each skill bloats the system prompt. More isn't better.

**Not reading the system prompt**
You're flying blind if you don't know what instructions Claude already has.

</div>

---

# How to stay sharp

<div class="space-y-5 mt-6 text-lg">

**Use subagents for isolated tasks**
Keeps the main thread clean. Subagents don't pollute your context.

**Load skills intentionally**
Start with nothing. Add one when you actually need it.

**Watch the status line**
Claude Code shows token usage. Know when you're running low on runway.

**Demo: read the system prompt**
You can literally ask Claude what it knows. Most people never do.

</div>

---
layout: center
class: text-center
---

# Demo — what does Claude see right now?

<div class="mt-6 opacity-50 text-lg">Ask Claude to summarise its own system prompt</div>

---
layout: center
class: text-center
---

# Harness

---

# The core idea

<div class="text-2xl mt-8 leading-relaxed">

AI writes code. Then it needs to **run** the code, **read** the output, and **fix** what's wrong — without you babysitting every step.

</div>

<div class="mt-10 text-xl opacity-60">That loop is the harness.</div>

---

# Three tools that close the loop

<div class="grid grid-cols-3 gap-8 mt-8 text-center">

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">🪵</div>
  <div class="text-xl font-bold">Log Inspector</div>
  <div class="mt-3 text-sm opacity-50">AI reads what the app actually did — not what it thinks it did</div>
  <div class="mt-4 font-mono text-xs opacity-30">skill: log-tail</div>
</div>

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">🗄️</div>
  <div class="text-xl font-bold">DB Inspector</div>
  <div class="mt-3 text-sm opacity-50">Check the data, not just the code that writes it</div>
  <div class="mt-4 font-mono text-xs opacity-30">skill: sqlite-inspector</div>
</div>

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">🧪</div>
  <div class="text-xl font-bold">API Tester</div>
  <div class="mt-3 text-sm opacity-50">AI hits the endpoints itself and reads the results</div>
  <div class="mt-4 font-mono text-xs opacity-30">skill: api-test</div>
</div>

</div>

---
layout: center
class: text-center
---

# Demo — two projects, live harness

<div class="mt-8 space-y-2 opacity-50 text-left inline-block text-sm">
  <div>→ Start backend + frontend</div>
  <div>→ AI inspects logs</div>
  <div>→ AI queries the database</div>
  <div>→ AI runs API tests</div>
  <div>→ AI finds the bug, fixes it</div>
</div>

---
layout: center
class: text-center
---

# That's the whole game

<div class="mt-8 text-2xl">
Give AI a clear picture of what to do.<br/>
Give it the tools to know if it worked.
</div>

<div class="mt-10 text-5xl font-bold">Context + Harness.</div>

---
layout: center
class: text-center
---

# Questions?

<div class="mt-6 opacity-40 text-sm">MentorCruise Webinar · 2026</div>
