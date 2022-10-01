import { LogTypeEnum } from "./LogTypeEnum"

export interface Log {
    assigned_to: String
    equpiment_id: String
    timestamp: Date
    comment: String
    type: LogTypeEnum
}
