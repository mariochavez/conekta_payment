class CardWidget
  container: '#card'
  number_input: 'input#card_number'
  expiry_input: 'input#card_expiry'
  cvc_input: 'input#card_cvc'
  name_input: 'input#card_name'

  constructor: (@form, @translations, @values) ->
    $.card.messages = @translations
    $.card.values = @values

    ($ @form).card
      container: @container,
      numberInput: @number_input,
      expiryInput: @expiry_input,
      cvcInput: @cvc_input,
      nameInput: @name_input

window.CardWidget = CardWidget
