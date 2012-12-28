; Remove both braces when deleting left brace in #{}
((ViMap insertMap) map:"<bs>" to:"<bs><del>" scope:"source.ruby.embedded.source.empty")

; Overwrite '}' in #{ .. }
((ViMap insertMap) map:"}" toExpression:(do ()
	(let (text (current-text))
		(if (eq '}' (text currentCharacter))
			(text input:"<right>")
			(else (text input:"<ctrl-v>}"))))) scope:"source.ruby string.quoted source.ruby.embedded")

