import { Engineer } from "./Engineer"
import { StatusEnum } from "./TaskStatusEnum"

export interface Task {
    id: String
    title: String
    description: String
    priority: String
    status: StatusEnum
    assigned: String
    repeat: number
    lastDone: Date
}
