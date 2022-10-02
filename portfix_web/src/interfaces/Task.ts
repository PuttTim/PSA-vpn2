import { DateTime } from "luxon"

export interface Task {
    id: string
    equipmentId: string
    engineerId?: string | null
    title: string
    description: string
    priority: 1 | 2 | 3
    status: "Not Started" | "In Progress"
    repeat: number // repeat value is in days
    dueDate: DateTime
}
