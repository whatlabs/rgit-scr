# rgit-scr
---
## Recursive Git Scripts - scripts to make git submodule recursion generally consistent and intuitive
- rgit.sh, git command switch-case that determines head or tail recursion for testing purposes
- rgsm.sh, similar to 'git submodule foreach --recursive' but allows head or tail recursion

---
## rgsm-0, the root of the nested submodules to be used for testing
- __rgsm-0__: Four children, four grandchildren, and one great grandchild
  - rgsm-1
    - rgsm-2
      - rgsm-3
  - rgsm-4
    - rgsm-5
    - rgsm-6
  - rgsm-7
    - rgsm-8
  - rgsm-9:
