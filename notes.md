Notes, primarily for myself but also for potential contributors. These are specific steps I do not want to have to figure out again.

# Docs

Generating the docs is a bit complicated at the moment.

- First, change to MRI via `rbenv local 2.0.0-rc2`.

- Next, run `yard doc - Example.html -m markdown`.

- Remove the contents of `doc/file.Example.html` and replace them with the contents of `./Example.html`.

- Copy those files to a tmp directory `cp -r doc/ ~/tmp/doc`.

- Delete `doc/file.Example.html`.

- Run `yard -m markdown`.

- Back to jruby: `rbenv local jruby-1.7.4` (When the fixes to Ripper go into jruby, this ruby swapping to run yard will not be necessary).

- Commit changes.

- `git checkout gh-pages`.

- `rm -rf .`

- `cp -r ~/tmp/doc/* .`

- Commit changes and push.

- `git checkout master`.

- Build and push gem to update docs showing up on sites like rubydoc.info

# Specs

Run specs with either `rake spec` or `rspec spec`.

# Build gem

- Make sure you update version in smart_diff.gemspec first.

- `rake build_gem`

- push with `gem push pkg/smart_diff-?.?.?.gem`
