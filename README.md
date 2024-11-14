# Dotfiles

```sh
xcode-select --install
git clone https://github.com/de-luca/dotfiles.git $HOME/.dotfiles
```

## Troubleshooting

### Antigen fails on startup
**Symptom:**
```
tee: /Users/***/.antigen/bundles/robbyrussell/oh-my-zsh/cache//completions/_docker: No such file or directory
```
**Fix:**
```sh
mkdir ~/.antigen/bundles/robbyrussell/oh-my-zsh/cache/completions
```

### MacOS init spew lots of errors
**Symptom:**
```
2024-11-05 21:43:02.595 defaults[28988:140191] Could not write domain /Users/***/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari; exiting
```
**Fix:** Give Full Disk Access to iTerm