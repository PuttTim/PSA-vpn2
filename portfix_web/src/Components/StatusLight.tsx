// @ts-nocheck

import React from "react"
import { render } from "react-dom"
import "status-indicator/styles.css"

type StatusLightProps = {
    color: "green" | "yellow" | "red" | "redPulse"
}

const StatusLight = (props: StatusLightProps) => {
    const statusLight = () => {
        switch (props.color) {
            case "green":
                return <status-indicator positive />
            case "yellow":
                return <status-indicator intermediary />
            case "red":
                return <status-indicator negative />
            case "redPulse":
                return <status-indicator negative pulse />
        }
    }

    return <div>{statusLight()}</div>
}

export default StatusLight
