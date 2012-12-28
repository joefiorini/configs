;(load "console")
;(global console ((NuConsoleWindowController alloc) init))
;(console toggleConsole:nil)

(function expand-current-directory ()
  ((((ExParser sharedParser) expand:"%:h" error:nil))))

(function edit-with-current-directory ()
  (do () ((current-text) input:(+ ":e " (expand-current-directory)))))

((ViMap normalMap) map:"\\\\e" toExpression: (edit-with-current-directory))
((ViMap normalMap) setKey:"\\\\\\" toAction:"switch_file:")
((ViMap insertMap) map:"<shift-bs>" to:"<bs>")
((ViMap insertMap) map:"<shift-cr>" to:"<cr>")
