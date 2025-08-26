import SwiftUI

// Main ContentView that displays the list of protocols
struct ContentView: View {
    let protocols = ProtocolData.getProtocols()

    var body: some View {
        NavigationView {
            List(protocols) { protocol in
                NavigationLink(destination: ProtocolDetailView(protocol: protocol)) {
                    Text(protocol.title)
                        .font(.headline)
                }
            }
            .navigationTitle("EMS Protocols")
        }
    }
}

// Detail view for a single protocol
struct ProtocolDetailView: View {
    let protocol: Protocol

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(protocol.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                Text(protocol.description)
                    .font(.body)

                // Displaying steps if they exist
                if !protocol.steps.isEmpty {
                    ForEach(protocol.steps, id: \.self) { step in
                        HStack(alignment: .top) {
                            Text("•")
                            Text(step)
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(protocol.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Protocol data model
struct Protocol: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let steps: [String]
}

// Sample data based on the PDF
struct ProtocolData {
    static func getProtocols() -> [Protocol] {
        return [
            Protocol(title: "Protocol 1 - General Medical/Trauma",
                     description: "This protocol addresses treatment of patients who present with conditions that do not fall under a more specific protocol, but in whom the provider determines a need for oxygen therapy, cardiac monitoring, vascular access, and/or pain management.",
                     steps: [
                        "Assess Patient",
                        "Provide Oxygen to maintain an oxygen saturation of 95%",
                        "Check blood glucose level if necessary",
                        "IV/INT Normal Saline or Lactated Ringers",
                        "If unable to obtain IV access and/or patient meets criteria for IO use, initiate IO of Normal Saline or Lactated Ringers.",
                        "For patients experiencing nausea or vomiting: Zofran 4mg IV over 2-5 minutes or 4mg PO",
                        "For Pain Management: See Protocol 2",
                        "For Combative patients secondary to trauma, or for procedural sedation: Versed 2.5 mg IV/IM/IN, may repeat once OR Ativan 1mg IV/IM, may repeat once OR Ketamine 0.5 mg/kg IV or 1-2 mg/kg IM up to 200 mg maximum single dose"
                     ]),
            Protocol(title: "Protocol 2 - Pain Management",
                     description: "This protocol addresses the need to administer pain management to patients presenting with a pain scale of 6 or greater, AND isolated musculoskeletal trauma (with obvious injury) and/or burns. This protocol is not intended for patients with chronic pain, abdominal pain, or new atraumatic pain. Providers may not use this protocol in patients with hypotension, head injury, or respiratory depression.",
                     steps: [
                        "Ensure Adequate Oxygenation",
                        "Monitor EtCO2 levels",
                        "Ibuprofen 10mg/kg PO, MAX 400mg if Age > 5 months OR Acetaminophen 15 mg/kg PO, max 1000mg if Age > 3 months",
                        "Initiate IV of Normal Saline or Lactated Ringers.",
                        "Consider Zofran 4mg IV over 2-5 minutes or 4mg PO for nausea",
                        "Fentanyl: 1-2mcg/kg IV/IN/IM/IO up to 100mcg OR Morphine: 0.1 mg/kg up to 5mg IV/IM/10 OR Ketamine: 0.25 mg/kg IV/IO or 0.5 mg/kg IM. May repeat once.",
                        "Reassess patient at least every 5 minutes",
                        "Notify Destination or Contact MC"
                     ]),
            Protocol(title: "Protocol 5 - Reactive Airway Disease",
                     description: "This protocol applies to patients presenting with respiratory distress consistent with reactive airway disease to include symptoms of wheezing and/or stridor, as well as decreased air movement. Patients may have history of COPD, Emphysema, Asthma, or similar conditions.",
                     steps: [
                        "Provide Oxygen to maintain an oxygen saturation of 95%",
                        "Utilize End Tidal CO2 monitoring/ capnography",
                        "Albuterol 2.5mg via handheld nebulizer at 6L",
                        "Based on patient presentation, Apply CPAP at 0-10cmm of PEEP titrated to effect",
                        "Repeat Albuterol 2.5 mg + Atrovent 500mcg via nebulizer at 6L",
                        "Solu-Medrol: 125mg IVP",
                        "IM Epinephrine 1:1,000: 0.01 mg/kg to a max of 0.3 mg",
                        "Magnesium Sulfate: 2 grams into 100mL NS IV/IO over 20 minutes"
                     ])
        ]
    }
}

// The main App structure
@main
struct EMSProtocolApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
