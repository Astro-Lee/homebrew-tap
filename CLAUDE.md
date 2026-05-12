@/opt/homebrew/AGENTS.md

---

# Tap-specific guidance (astro-lee/homebrew-tap)

Guidance for maintaining this Homebrew tap, based on [How to Create and Maintain a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap).

**Precedence:** The brew core `@/opt/homebrew/AGENTS.md` above covers general Homebrew contribution rules (Ruby style, Sorbet types, testing). The sections below are tap-specific conventions that supplement it. When they conflict, tap-specific rules take precedence.

## Directory structure

- `Formula/` — all formula files (`.rb`). This is the only directory Homebrew reads for formulae in this tap.
- `.github/workflows/` — CI definitions (tests.yml, publish.yml). Keep these in sync with `brew tap-new` templates.
- `README.md` — user-facing install instructions.

## Creating a new formula

```bash
brew create <tarball-url> --tap astro-lee/tap
```

Formula files follow the same DSL as homebrew-core. Key sections in order:
1. `desc` — short description
2. `homepage` — project URL
3. `url` — source tarball with version tag
4. `sha256` — verify with `curl -L <url> | shasum -a 256`
5. `depends_on` — build and runtime dependencies
6. `def install` — cmake/make/configure steps
7. `def caveats` — optional; post-install messages
8. `test` — minimal smoke test (assert file exists, run `--version`, etc.)

## Before pushing changes

```bash
# Syntax check
brew style Formula/<formula>.rb

# Build-from-source test
brew install --build-from-source astro-lee/tap/<formula>

# Run test block
brew test astro-lee/tap/<formula>

# Full audit
brew audit --strict astro-lee/tap/<formula>
```

## Version bumps

1. Update `url` to the new tarball URL (tagged release).
2. Compute new `sha256`: `curl -L <new-url> | shasum -a 256`
3. If the build directory changed (e.g. `MultiNest_v3.12_CMake` → `MultiNest_v3.13_CMake`), update the `cd` path in `def install`.
4. Test with `brew install --build-from-source` and `brew test`.

## CI setup (already in place)

- **tests.yml**: runs `brew test-bot` on push to `main` and on PRs. Matrix: macos-15-intel, macos-26, ubuntu-latest. Syntax check always runs; `--only-formulae` runs on PRs. Bottle artifacts uploaded for PRs.
- **publish.yml**: triggered by `pr-pull` label on PRs. Runs `brew pr-pull` to fetch bottles, commits them, and pushes to `main`.

## Conventions for this tap

- Formulae that need Fortran: depend on `gcc` (provides `gfortran`) and `open-mpi`.
- CMake-based builds: use `std_cmake_args` in `system "cmake", "-B", "build", *std_cmake_args`.
- Tests: assert installed files exist (`.dylib`, `.h`, etc.) with `assert_path_exists`.
- Use spaces inside hashes (`depends_on "cmake" => :build`), consistent with Homebrew Ruby style.
- Follow the existing `multinest.rb` formula as a reference for style and structure.

## Naming

If a formula name conflicts with a homebrew/core formula, rename it to avoid clashes (e.g., append a suffix). This tap's names currently don't conflict, but check before adding.

## Helpful commands

| Command | Purpose |
|---------|---------|
| `brew tap-new --help` | Show tap template creation options |
| `brew create --help` | Show formula creation options |
| `brew extract --help` | Copy a historical formula from core |
| `brew livecheck --tap astro-lee/tap` | Check for formula updates |
| `brew audit --tap astro-lee/tap` | Audit all formulae in this tap |
