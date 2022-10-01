import { LogTypeEnum } from "./LogTypeEnum"

export interface Log {
    assignedTo: String
    equpimentId: String
    timestamp: Date
    comment: String
    type: LogTypeEnum
}
