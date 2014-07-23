`/** @jsx React.DOM */`

'use strict'

var React = require 'react/addons'
require '../../styles/<%= classedName %>.css'

<%= classedName %> = React.createClass({
  render: ->
    `<div>
      <p>Content for <%= classedName %></p>
    </div>`

module.exports = <%= classedName %>
