import { DateTime } from "luxon"

export interface Log {
    id: string
    title: string
    engineerId: string
    equipmentId: string
    timestamp: DateTime
    comment: string
    type: "Cancelled" | "Completed"
}
