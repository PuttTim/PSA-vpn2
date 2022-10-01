export interface Task {
    id: string
    equipmentId: string
    title: string
    description: string
    priority: 1 | 2 | 3
    status: "Not Started" | "In Progress"
    engineerId?: string
    repeat: number // repeat value is in days
    dueDate?: Date
}
