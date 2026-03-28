I started out trying for all-in-one repos because they are convenient for noobs.

But too many duplicate long build steps over and over.

The whole point of build system is that you build something once and that's that.

So here's android build for LuaJIT.

It puts the include and jit folder in one ABI unique location: `dist/android/$(abi)/`.

Off that is the following:

- `bin/` - just has `luajit`.
- `lib/` - has `libluajit.so` and `libluajit.a`
- `include/` - has all the files needed for building C stuff with LuaJIT.
- `jit` - has all the `.lua` files needed for `-j` to work.
