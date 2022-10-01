export interface Log {
    id: String
    title: String
    engineerId: String
    equipmentId: String
    timestamp: Date
    comment: String
    type: "Cancelled" | "Completed"
}
