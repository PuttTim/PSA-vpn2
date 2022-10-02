export interface Log {
    id: string
    title: string
    engineerId: string
    equipmentId: string
    timestamp: Date
    comment: string
    type: "Cancelled" | "Completed"
}
