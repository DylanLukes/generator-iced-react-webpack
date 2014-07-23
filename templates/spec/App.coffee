'use strict'

describe '<%= classedName %>', ->
  var <%= scriptAppName %>, component

  beforeEach ->
    container = document.createElement 'div'
    container.id = 'content'
    document.body.appendChild container 

    <%= scriptAppName %> = require '../../../src/scripts/components/<%= scriptAppName %>.iced'
    component = do <%= scriptAppName %>

  it 'should create a new instance of <%= scriptAppName %>', ->
    expect(component).toBeDefined()
