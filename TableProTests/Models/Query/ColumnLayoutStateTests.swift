//
//  ColumnLayoutStateTests.swift
//  TableProTests
//

import Foundation
import Testing

@testable import TablePro

@Suite("ColumnLayoutState.applyGeometry")
struct ColumnLayoutStateTests {
    @Test("Applying geometry updates widths and order")
    func updatesWidthsAndOrder() {
        var layout = ColumnLayoutState()
        layout.columnWidths = ["id": 60]
        layout.columnOrder = ["id"]

        var incoming = ColumnLayoutState()
        incoming.columnWidths = ["id": 120, "name": 200]
        incoming.columnOrder = ["name", "id"]

        layout.applyGeometry(from: incoming)

        #expect(layout.columnWidths == ["id": 120, "name": 200])
        #expect(layout.columnOrder == ["name", "id"])
    }

    @Test("Applying geometry preserves the existing hidden-column set")
    func preservesHiddenColumns() {
        var layout = ColumnLayoutState()
        layout.hiddenColumns = ["secret", "internal_id"]

        var incoming = ColumnLayoutState()
        incoming.columnWidths = ["id": 120]
        incoming.columnOrder = ["id"]

        layout.applyGeometry(from: incoming)

        #expect(layout.hiddenColumns == ["secret", "internal_id"])
    }

    @Test("Applying geometry ignores the incoming hidden-column set")
    func ignoresIncomingHiddenColumns() {
        var layout = ColumnLayoutState()
        layout.hiddenColumns = ["secret"]

        var incoming = ColumnLayoutState()
        incoming.columnWidths = ["id": 120]
        incoming.hiddenColumns = []

        layout.applyGeometry(from: incoming)

        #expect(layout.hiddenColumns == ["secret"])
    }
}
