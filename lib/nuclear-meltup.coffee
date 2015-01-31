NuclearMeltupView = require './nuclear-meltup-view'
{CompositeDisposable} = require 'atom'

module.exports = NuclearMeltup =
  nuclearMeltupView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @nuclearMeltupView = new NuclearMeltupView(state.nuclearMeltupViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @nuclearMeltupView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'nuclear-meltup:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @nuclearMeltupView.destroy()

  serialize: ->
    nuclearMeltupViewState: @nuclearMeltupView.serialize()

  toggle: ->
    console.log 'NuclearMeltup was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
