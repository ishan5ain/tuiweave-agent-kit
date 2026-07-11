package main

import "github.com/ishansain/gotui/snaptest"

func auditCoverageNames() {
	_ = snaptest.Snap
	_ = snaptest.RunScenario[model]
}
