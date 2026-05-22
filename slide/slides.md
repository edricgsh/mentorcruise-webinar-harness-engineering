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

<div class="mt-8 text-xl opacity-60">Same model. Same tool. But wildy different experience</div>

---
layout: center
class: text-center
---

# Two things decide the outcome

<div class="grid grid-cols-2 gap-16 mt-10 text-left">
<div class="text-center">
  <div class="text-5xl mb-4">🧠</div>
  <div class="text-2xl font-bold">Context</div>
  <div class="mt-2 opacity-60">What's going in the context window</div>
</div>
<div class="text-center">
  <div class="text-5xl mb-4">🔧</div>
  <div class="text-2xl font-bold">Harness</div>
  <div class="mt-2 opacity-60">What's in the agent's environment</div>
</div>
</div>

---

# The common mistakes people make

<div class="space-y-6 mt-6 text-lg">

**Letting context rot**
Long sessions compress old messages. AI from message 50 has forgotten what you agreed on at message 5. Use `/clear` between unrelated tasks.

**Not letting AI run anything**
AI codes blind. It writes code and hopes, can't run tests, can't hit endpoints, can't read logs. No way to check its own work, no way to verify fixes. It's just guessing.

</div>

---
layout: center
class: text-center
---

# Context

---

# What's actually in your AI's context right now?

<div class="grid grid-cols-3 gap-8 mt-8 text-center">

<div class="p-4 rounded-lg border border-white/20">
  <div class="text-3xl mb-3">⚙️</div>
  <div class="font-bold">System prompt + tools</div>
  <div class="mt-2 text-sm opacity-50">Set directly via settings or --system-prompt. CLAUDE.md, system tools (Read, Grep, Write and so on)</div>
</div>

<div class="p-4 rounded-lg border border-white/20">
  <div class="text-3xl mb-3">🛠️</div>
  <div class="font-bold">Skills & MCP tools</div>
  <div class="mt-2 text-sm opacity-50">Every loaded skill adds tokens. Install too many and it becomes noise.</div>
</div>

<div class="p-4 rounded-lg border border-white/20">
  <div class="text-3xl mb-3">💬</div>
  <div class="font-bold">Messages</div>
  <div class="mt-2 text-sm opacity-50">Your full conversation history. Gets compressed as it grows — old context quietly disappears.</div>
</div>

</div>

<!--
Harness
1. Claude Code demo
2. Pi demo
-->

---
layout: center
class: text-center
---

# Demo — controlling what Claude sees

<div class="mt-6 opacity-50 text-lg">CLAUDE.md · Skills · MCP tools — what's loaded, what's not</div>

---

# More tips to stay keep the context window size manageable

<div class="space-y-5 mt-6 text-lg">

**Use subagents for isolated tasks**
Keeps the main thread clean. Subagents don't pollute your context.

**Load skills intentionally**
Start with nothing. Add one when you actually need it.

**Watch the status line**
Claude Code shows token usage. Know when you're running low on runway.


</div>

---
layout: center
class: text-center
---

# Harness

---

# The core idea

<div class="text-xl mt-8 space-y-4">

**AI's job:**
- Write the code
- Run it and read the output
- Fix what's wrong — without you babysitting every step

**Your job as a human:**
- Set up the optimal environment at the start
- For each requirement, define the spec and success criteria clearly
- Validate the output at the end

</div>

---

# Setting up the environment

<div class="space-y-5 mt-6 text-lg">

**Give AI the right tools**
Skills for log reading, API testing, and DB inspection — so it can verify its own work, not just write code and hope.

**Isolate environments with git worktrees**
Separate ports and databases per branch. Parallel features never step on each other, and AI can run two tasks simultaneously.

**Have a dedicated output area**
A folder for test reports, logs, and assertions. AI writes there; you review there.

</div>

---

# When to write a spec (and when not to)

<div class="space-y-5 mt-6 text-lg">

**Not every task needs a spec**
For simple, well-understood changes — *"rename this field"*, *"add a missing index"* — a spec is overhead. Just describe what you want and let the AI run.

**Write a spec when the requirement is complex**
If the feature touches multiple layers, has tricky edge cases, or you can't describe it in one sentence — invest the time upfront.

**The spec is the AI's exit condition**
Without one, done means *"I stopped typing"*. With one, the AI checks itself — runs the endpoint, reads the result, fixes the delta.

</div>

---

# Validate the output

<div class="grid grid-cols-3 gap-8 mt-8 text-center">

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">👁️</div>
  <div class="text-xl font-bold">Code review</div>
  <div class="mt-3 text-sm opacity-50">Read the diff before you ship it. AI-generated code can be subtly wrong in ways tests don't catch — logic errors, missing edge cases, security gaps.</div>
</div>

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">📄</div>
  <div class="text-xl font-bold">Read the test output</div>
  <div class="mt-3 text-sm opacity-50">Don't just ask "did it pass?" — read what the AI actually tested. A green report with shallow assertions is still a gap.</div>
</div>

<div class="p-6 rounded-lg border border-white/20">
  <div class="text-4xl mb-4">🔍</div>
  <div class="text-xl font-bold">Cross-check data & logs</div>
  <div class="mt-3 text-sm opacity-50">Does the database actually contain what you expect? Do the logs show the right requests? Trust evidence, not the AI's summary of evidence.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Demo — two projects, live harness

Writing two features simultaneously

---
layout: center
class: text-center
---

# Questions?

<div class="mt-6 opacity-40 text-sm">MentorCruise Webinar · 2026</div>
