export interface Task {
    id: String
    equipmentId: String
    title: String
    description: String
    priority: 1 | 2 | 3
    status: "Not Started" | "In Progress"
    engineerId?: String
    repeat: number // repeat value is in days
    lastDone?: Date
}
