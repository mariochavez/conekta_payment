class PreProcess
  errors: {}
  values: {}

  validators:
    card_number:
      validator: 'validateNumber'
      klass: Conekta.card
    card_cvc:
      validator: 'validateCVC'
      klass: Conekta.card
    card_name:
      validator: 'validateName'
      klass: Conekta.card
    card_expiry:
      validator: 'validateExpiry'
      klass: PreProcess
    email:
      validator: 'validateEmail'
      klass: PreProcess

  error_messages:
    email: 'Email inválido'
    card_number: 'Número inválido'
    card_cvc: 'Número inválido'
    card_name: 'Nombre inválido'
    card_expiry: 'Fecha inválida'

  card_fields:
    email: 'pay_email'
    card_number: 'card_number'
    card_cvc: 'card_cvc'
    card_name: 'card_name'
    card_expiry: 'card_expiry'

  config:
    message_area_class: 'message-area'
    message_area_error_class: 'error-area'
    field_error_class: 'error'
    message_area: 'Se encontraron los siguientes errores al procesar su pago:'

  @validateEmail: (email) ->
    email.trim().length > 5

  @validateExpiry: (date) ->
    [month, year] = PreProcess.formatDate(date)
    Conekta.card.validateExpirationDate(month, year)

  @formatDate: (date) ->
    values = date.split('/')
    values = [values[0], ''] if values.length == 1
    [values[0].trim(), values[1].trim()]

  constructor: (form, button, options = {}) ->
    @$form = ($ form)
    @$button = ($ button)
    @$form.submit @processForm

    jQuery.extend(@validators, options.validators) if options['validators']
    jQuery.extend(@card_fields, options.fields) if options['fields']
    jQuery.extend(@error_messages, options.messages) if options['messages']
    jQuery.extend(@config, options.config) if options['config']

    @$button.attr('disabled', false)

  processForm: (sender) =>
    sender.preventDefault()
    @$button.attr('disabled', true)
    @clearErrors(@$form)

    unless @validate(@$form)
      @renderErrors @$form, @errors
      @$button.attr('disabled', false)

  clearErrors: (form) ->
    form.find('.error').removeClass('error')
    message_area = form.find('.message-area')
    message_area.removeClass 'error-area'
    message_area.html()

  renderErrors: (form, errors) ->
    message_area = form.find('.message-area')

    error_messages = ''
    for field, message of errors
      form.find("##{field}").addClass 'error'
      error_messages += "#{message}, "

    message_area.addClass 'error-area'
    message_area.html "<p>#{@config.message_area} #{error_messages.trim().slice(0, -1)}</p>"

  debugObject: (message, object) ->
    console.log "#{message} :: #{JSON.stringify(object)}"

  validate: (form) ->
    @errors = {}
    @values = {}

    for field, field_name of @card_fields
      validator = @validators[field].validator
      klass = @validators[field].klass

      unless klass[validator](@getFieldValue(form, field_name))
        @setProperty @errors, @error_messages[field], field_name

    Object.keys(@errors).length == 0

  setProperty: (object, value, field) =>
    Object.defineProperty object, field,
      value: value
      enumerable: true

  getFieldValue: (form, field) =>
    value = form.find("##{field}").val()
    @setProperty @values, value, field
    value

window.PreProcess = PreProcess
