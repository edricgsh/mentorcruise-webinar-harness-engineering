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

# Why does AI write great code<br>for some people...

## ...and garbage for others?

<div class="mt-8 text-xl opacity-50">Same model. Same tool. Wildly different experience.</div>

---
layout: center
class: text-center
---

# Two things decide the outcome

<div class="grid grid-cols-2 gap-16 mt-12 max-w-2xl mx-auto">

<div>
  <div class="text-6xl mb-4">🧠</div>
  <div class="text-2xl font-bold mb-2">Context</div>
  <div class="opacity-50 text-lg">What goes into<br>the context window</div>
</div>

<div>
  <div class="text-6xl mb-4">🔧</div>
  <div class="text-2xl font-bold mb-2">Harness</div>
  <div class="opacity-50 text-lg">What tools the agent<br>has at its disposal</div>
</div>

</div>

---
layout: center
class: text-center
---

# The common mistakes people make

<div class="grid grid-cols-2 gap-8 mt-6">

<div class="p-5 rounded-xl bg-red-500/10 border border-red-500/20">
  <div class="text-2xl mb-2">🪟</div>
  <div class="text-lg font-bold mb-1">Letting context rot</div>
  <div class="text-sm opacity-60">Long sessions compress old messages.<br>From message 50, the AI forgets what<br>you agreed on at message 5.</div>
  <div class="mt-2 text-xs font-mono opacity-70">Use <code>/clear</code> between unrelated tasks</div>
</div>

<div class="p-5 rounded-xl bg-red-500/10 border border-red-500/20">
  <div class="text-2xl mb-2">🙈</div>
  <div class="text-lg font-bold mb-1">Not letting AI run anything</div>
  <div class="text-sm opacity-60">AI codes blind — writes code and hopes.<br>No tests, no endpoints, no logs.</div>
  <div class="mt-2 text-xs font-mono opacity-70">It's just guessing</div>
</div>

</div>

---
layout: center
class: text-center
---

# Context

---
layout: center
class: text-center
---

# What's in your AI's context right now?

<div class="grid grid-cols-3 gap-6 mt-8 max-w-3xl mx-auto">

<div class="p-5 rounded-xl bg-blue-500/10 border border-blue-500/20">
  <div class="text-3xl mb-3">⚙️</div>
  <div class="font-bold mb-1">System prompt + tools</div>
  <div class="text-xs opacity-60">CLAUDE.md, system instructions,<br>built-in tools (Read, Write, Bash)</div>
</div>

<div class="p-5 rounded-xl bg-blue-500/10 border border-blue-500/20">
  <div class="text-3xl mb-3">🛠️</div>
  <div class="font-bold mb-1">Skills & MCP tools</div>
  <div class="text-xs opacity-60">Every loaded skill costs tokens.<br>Too many becomes noise.</div>
</div>

<div class="p-5 rounded-xl bg-blue-500/10 border border-blue-500/20">
  <div class="text-3xl mb-3">💬</div>
  <div class="font-bold mb-1">Message history</div>
  <div class="text-xs opacity-60">Compressed as it grows.<br>Old context quietly disappears.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Demo

CLAUDE.md · Skills · MCP tools —<br>what's loaded, what's not

---
layout: center
class: text-center
---

# Tips to keep context manageable

<div class="grid grid-cols-3 gap-5 mt-8 max-w-3xl mx-auto">

<div class="p-4 rounded-xl bg-green-500/10 border border-green-500/20">
  <div class="text-xl mb-2">🔀</div>
  <div class="font-bold mb-1">Use subagents</div>
  <div class="text-xs opacity-60">Isolate tasks — subagents<br>don't pollute your<br>main thread.</div>
</div>

<div class="p-4 rounded-xl bg-green-500/10 border border-green-500/20">
  <div class="text-xl mb-2">🎒</div>
  <div class="font-bold mb-1">Load skills intentionally</div>
  <div class="text-xs opacity-60">Start with nothing.<br>Add a skill only when<br>you need it.</div>
</div>

<div class="p-4 rounded-xl bg-green-500/10 border border-green-500/20">
  <div class="text-xl mb-2">📊</div>
  <div class="font-bold mb-1">Watch the status line</div>
  <div class="text-xs opacity-60">Claude Code shows tokens.<br>Know when you're running<br>low on runway.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Harness

---
layout: center
class: text-center
---

# The core idea

<div class="grid grid-cols-2 gap-12 mt-10 max-w-3xl mx-auto">

<div class="text-left p-6 rounded-xl bg-emerald-500/10 border border-emerald-500/20">
  <div class="text-center text-4xl mb-4">🤖</div>
  <div class="text-center text-xl font-bold mb-4">AI's job</div>
  <div class="space-y-3 text-lg opacity-80">
    <div>→ Write the code</div>
    <div>→ Run it and read the output</div>
    <div>→ Fix what's wrong</div>
  </div>
</div>

<div class="text-left p-6 rounded-xl bg-sky-500/10 border border-sky-500/20">
  <div class="text-center text-4xl mb-4">🧑</div>
  <div class="text-center text-xl font-bold mb-4">Your job</div>
  <div class="space-y-3 text-lg opacity-80">
    <div>→ Set up the environment</div>
    <div>→ Define spec & success criteria</div>
    <div>→ Validate the output</div>
  </div>
</div>

</div>

---
layout: center
class: text-center
---

# Setting up the environment

<div class="grid grid-cols-3 gap-6 mt-10 max-w-5xl mx-auto">

<div class="p-5 rounded-xl bg-violet-500/10 border border-violet-500/20">
  <div class="text-2xl mb-2">🧰</div>
  <div class="font-bold mb-1">Give AI the right tools</div>
  <div class="text-sm opacity-60">Skills for log reading, API testing,<br>DB inspection — so it can verify<br>its own work.</div>
</div>

<div class="p-5 rounded-xl bg-violet-500/10 border border-violet-500/20">
  <div class="text-2xl mb-2">🌳</div>
  <div class="font-bold mb-1">Isolate with git worktrees</div>
  <div class="text-sm opacity-60">Separate ports & databases.<br>Parallel features never<br>step on each other.</div>
</div>

<div class="p-5 rounded-xl bg-violet-500/10 border border-violet-500/20">
  <div class="text-2xl mb-2">📁</div>
  <div class="font-bold mb-1">Dedicated output area</div>
  <div class="text-sm opacity-60">A folder for test reports, logs,<br>assertions. AI writes there —<br>you review there.</div>
</div>

</div>

---
layout: center
class: text-center
---

# When to write a spec

<div class="grid grid-cols-3 gap-6 mt-10 max-w-5xl mx-auto">

<div class="p-5 rounded-xl">
  <div class="text-2xl mb-2">✂️</div>
  <div class="font-bold mb-1">Skip the spec</div>
  <div class="text-sm opacity-60">Simple changes: rename a field,<br>add a missing index.<br>Just tell the AI what you want.</div>
</div>

<div class="p-5 rounded-xl bg-amber-500/10 border border-amber-500/20">
  <div class="text-2xl mb-2">📐</div>
  <div class="font-bold mb-1">Write a spec</div>
  <div class="text-sm opacity-60">Complex features that touch<br>multiple layers or have<br>tricky edge cases.</div>
</div>

<div class="p-5 rounded-xl bg-amber-500/10 border border-amber-500/20">
  <div class="text-2xl mb-2">🏁</div>
  <div class="font-bold mb-1">Spec = exit condition</div>
  <div class="text-sm opacity-60">Without one, "done" means<br>"I stopped typing." With one,<br>the AI checks itself.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Validate the output

<div class="grid grid-cols-3 gap-6 mt-10 max-w-5xl mx-auto">

<div class="p-5 rounded-xl bg-cyan-500/10 border border-cyan-500/20">
  <div class="text-3xl mb-3">👁️</div>
  <div class="font-bold mb-1">Code review</div>
  <div class="text-sm opacity-60">Read the diff before you ship.<br>Logic errors and missing edge<br>cases won't show up in tests.</div>
</div>

<div class="p-5 rounded-xl bg-cyan-500/10 border border-cyan-500/20">
  <div class="text-3xl mb-3">📄</div>
  <div class="font-bold mb-1">Read the test output</div>
  <div class="text-sm opacity-60">Don't just ask "did it pass?"<br>A green report with shallow<br>assertions is still a gap.</div>
</div>

<div class="p-5 rounded-xl bg-cyan-500/10 border border-cyan-500/20">
  <div class="text-3xl mb-3">🔍</div>
  <div class="font-bold mb-1">Cross-check data & logs</div>
  <div class="text-sm opacity-60">Does the DB look right?<br>Do logs show expected requests?<br>Trust evidence, not summaries.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Demo — two projects, live harness

Writing two features simultaneously

---

# Extending further — your company's stack

<div class="grid grid-cols-2 gap-4 mt-4 max-w-4xl mx-auto">

<div class="p-4 rounded-xl bg-white/5 border border-white/10">
  <div class="font-bold">📋 Log tailing</div>
  <div class="text-xs opacity-60 mt-1">Hook into Splunk, New Relic, Datadog.<br>The agent pulls live logs, finds root causes.</div>
</div>

<div class="p-4 rounded-xl bg-white/5 border border-white/10">
  <div class="font-bold">🔌 API testing</div>
  <div class="text-xs opacity-60 mt-1">Beyond HTTP — gRPC, Dubbo, JSON-RPC,<br>GraphQL. Whatever your services speak.</div>
</div>

<div class="p-4 rounded-xl bg-white/5 border border-white/10">
  <div class="font-bold">🗄️ Database access</div>
  <div class="text-xs opacity-60 mt-1">Connect to dev DBs — verify inserts,<br>join across tables, check data integrity.</div>
</div>

<div class="p-4 rounded-xl bg-white/5 border border-white/10">
  <div class="font-bold">☸️ Kubernetes</div>
  <div class="text-xs opacity-60 mt-1">Spin up / down containers in test clusters.<br>Isolated environments on demand.</div>
</div>

<div class="p-4 rounded-xl bg-white/5 border border-white/10">
  <div class="font-bold">📝 Spec writing</div>
  <div class="text-xs opacity-60 mt-1">Connect to Jira & Confluence — pull tickets,<br>read docs, brainstorm specs together.</div>
</div>

<div class="p-4 rounded-xl bg-orange-500/10 border border-orange-500/30">
  <div class="font-bold">🔑 One rule</div>
  <div class="text-xs opacity-80 mt-1"><strong>Read-only</strong> by default.<br><strong>Limited write</strong> to dev. Never prod.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Reference material

<div class="grid grid-cols-2 gap-4 mt-6 max-w-3xl mx-auto text-left">

<div class="p-3 rounded-lg bg-white/5 border border-white/10">
  <div class="text-xs opacity-40">langchain.com</div>
  <div class="font-bold text-sm">The Anatomy of an Agent Harness</div>
  <div class="text-xs opacity-60 mt-0.5">How filesystems, sandboxes, and memory<br>turn an LLM into an autonomous work engine.</div>
</div>

<div class="p-3 rounded-lg bg-white/5 border border-white/10">
  <div class="text-xs opacity-40">mariozechner.at</div>
  <div class="font-bold text-sm">Building an opinionated & minimal agent</div>
  <div class="text-xs opacity-60 mt-0.5">Lessons from building pi — a from-scratch<br>coding agent with a minimal toolset.</div>
</div>

<div class="p-3 rounded-lg bg-white/5 border border-white/10">
  <div class="text-xs opacity-40">anthropic.com</div>
  <div class="font-bold text-sm">Effective harnesses for long-running agents</div>
  <div class="text-xs opacity-60 mt-0.5">How state files, git, and init scripts keep<br>agents productive across many windows.</div>
</div>

<div class="p-3 rounded-lg bg-white/5 border border-white/10">
  <div class="text-xs opacity-40">martinfowler.com</div>
  <div class="font-bold text-sm">Harness engineering for coding agent users</div>
  <div class="text-xs opacity-60 mt-0.5">What harness engineering means for<br>everyday developers — not just tooling teams.</div>
</div>

</div>

---
layout: center
class: text-center
---

# Questions?

<div class="mt-6 opacity-40 text-sm">MentorCruise Webinar · 2026</div>
