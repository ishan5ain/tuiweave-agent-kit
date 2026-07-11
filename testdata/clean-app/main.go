package main

import (
	tea "charm.land/bubbletea/v2"

	"github.com/ishansain/gotui"
	"github.com/ishansain/gotui/textarea"
)

type model struct{ input textarea.Model }

func newModel() model { return model{input: textarea.New(gotui.Dark())} }

func (m model) Update(msg tea.Msg) (model, tea.Cmd) {
	if size, ok := msg.(tea.WindowSizeMsg); ok {
		m.input.SetSize(size.Width, size.Height)
	}
	var cmd tea.Cmd
	m.input, cmd = m.input.Update(msg)
	return m, cmd
}
