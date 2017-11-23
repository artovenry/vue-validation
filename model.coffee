S= require "string"

export default
  message:
    value: ""
    validate: (val)->[
      if S(val).isEmpty() then "必須入力です"
      else if val.length > 10 then "長すぎる"
    ]
  amount:
    value: 0
    validate: (val)->[
      if not _.include [0..5], val then "必須入力です"
    ]
