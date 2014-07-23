`/** @jsx React.DOM */`

'use strict'

React = require 'react/addons'
ReactTransitionGroup = React.addons.TransitionGroup

# Export React so the devtools can find it
((if window isnt window.top then window.top else window)).React = React

# Global CSS
require '../../styles/reset.css'
require '../../styles/main.css'

imageURL = '../../images/yeoman.png'

<%= scriptAppName %> = React.createClass
  render: ->
    `<div className='main'>
      <ReactTransitionGroup transitionName="fade">
        <img src={imageURL} />
      </ReactTransitionGroup>
    </div>`

React.renderComponent(`<<%= scriptAppName %> />`, document.getElementById 'content') # jshint ignore:line

module.exports = <%= scriptAppName %>
