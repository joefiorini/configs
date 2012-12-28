; Remove both braces when deleting left brace in #{}
((ViMap insertMap) map:"<bs>" to:"<bs><del>" scope:"source.nu.embedded.source punctuation.section.embedded.nu")

; Overtype ')'
((ViMap insertMap) map:")" toExpression:(do ()
	(let (text (current-text))
		(if (eq ')' (text currentCharacter))
			(text input:"<right>")
			(else (text input:"<ctrl-v>)"))))) scope:"source.nu")

