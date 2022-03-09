//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Samuel Seng on 1/31/22.
//

import Foundation
import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                // Since data is property wrapper by @State
                // we want to return the projected value by $
                // The projected value calls the setter which can
                // emit when things change
                // We do this since this view will edit
                // the value of title which we want to propogate back
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in:5...30, step:1) {
                        Text("Length")
                    }
                    .accessibilityLabel(Text("\(data.lengthInMinutes) minutes"))
                    Spacer()
                    // We want the wrappedValue not the projecedValue
                    // since we're not changing it in the text box
                    Text("\(Int(data.lengthInMinutes)) Minutes")
                        .accessibilityHidden(true)
                }
                ThemePickerView(selection: $data.theme)
            }
            Section(header: Text("attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete(perform: { idx in
                    data.attendees.remove(atOffsets: idx)
                })
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action:{
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
