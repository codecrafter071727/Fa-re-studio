# FA→RE Studio

An interactive FA (DFA/NFA) to Regular Expression converter using the **State Elimination** method.

## Features

| Feature | What it does |
|---|---|
| Two input methods | Edit a transition table or paste a text definition |
| GNFA construction | Automatically adds new start state **qs** and accept state **qf**, copies FA transitions |
| State elimination | Eliminates one interior state at a time using `R(i,j) ← R(i,j) | R(i,rip)·R(rip,rip)*·R(rip,j)` |
| Elimination order | Choose Auto (heuristic), Natural (q0, q1…), or Reverse |
| Step player | Play, pause, or scrub through each elimination step |
| Live GNFA diagram | Animated SVG graph with draggable nodes, zoom, pan, and fullscreen expand |
| Edge highlights | Dashed-animated edges show the eliminated state; purple edges show updated labels |
| GNFA table | Full R(i,j) matrix at each step, with updated cells highlighted |
| Result tab | Final RE with copy buttons, plus an elimination trace table |
| Formal tab | Formal 5-tuple definition of the input FA and the resulting RE |
| 6 preset examples | Ends with ab, even a's, contains aa, divisible by 3, ends in b, (a\|b)*abb |
| Auto-save | Your last FA is remembered in localStorage |
| Light/dark themes | System theme auto-detected, with manual override |

The app is a single HTML file with plain JavaScript. No dependencies, no npm, no build tools.

## Project layout

```
src/app.html     the app source (an HTML fragment)
build.sh         wraps src/app.html into a full page at docs/index.html
docs/index.html  the deployable site (already built)
vercel.json      Vercel config (serves docs/, no build step)
```

After editing `src/app.html`, rebuild with:

```bash
bash build.sh
```

## Run locally

Open `docs/index.html` in any browser. You can also serve it:

```bash
python3 -m http.server 8000 --directory docs
```

## Deploy

**Vercel** (already set up; this redeploys):

```bash
vercel deploy --prod
```

**Netlify Drop** (no account setup): open https://app.netlify.com/drop and drag the `docs` folder onto the page.

**GitHub Pages:**
1. Push this folder to a GitHub repo.
2. Go to Settings → Pages → Deploy from a branch.
3. Pick `main` and the `/docs` folder.

## Text format

```
# comments start with #
states: q0, q1, q2
alphabet: a, b
start: q0
final: q2
q0 a -> q1
q0 b -> q0
q1 a -> q2
q1 b -> q0
```

## Algorithm

**State Elimination** converts a FA to a Regular Expression:

1. **Build GNFA:** Add a new start state `qs` with ε-transition to the original start. Add a new accept state `qf` with ε-transitions from each original accept state. Copy all FA transitions as regex labels. Merge parallel transitions with `|`.

2. **Eliminate interior states:** For each state `rip` to eliminate:
   - For every pair (i, j) of remaining states, update:
     ```
     R(i,j) ← R(i,j) | R(i,rip) · R(rip,rip)* · R(rip,j)
     ```
   - Remove `rip` from the GNFA.

3. **Read the result:** When only `qs` and `qf` remain, the single edge label `R(qs, qf)` is the equivalent Regular Expression.

**Regex simplification rules used:**
- `∅ | R = R`
- `ε · R = R · ε = R`
- `∅ · R = R · ∅ = ∅`
- `∅* = ε`
- `ε* = ε`
