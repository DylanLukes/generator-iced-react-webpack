'use strict'

describe '<%= classedName %>', ->
  var <%= classedName %>, component

  beforeEach ->
    <%= classedName %> = require '../../../src/scripts/components/<%= classedFileName %>.iced'
    component = do <%= classedName %>

  it 'should create a new instance of <%= classedName %>', ->
    expect(component).toBeDefined()

