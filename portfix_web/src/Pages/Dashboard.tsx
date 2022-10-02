import React, { useEffect, useState } from "react"
import { getFirestore, collection, onSnapshot } from "firebase/firestore"
import firebaseInstance from "../firebase"
import { Equipment } from "../Interfaces/Equipment"
import { Task } from "../Interfaces/Task"
import { Log } from "../Interfaces/Log"
import {
    Box,
    Heading,
    HStack,
    Stat,
    VStack,
    StatLabel,
    StatNumber,
    StatHelpText,
    StatArrow,
    StatGroup,
    StackDivider,
    Center,
    Divider,
} from "@chakra-ui/react"
import { DateTime } from "luxon"
import LogNotificationCard from "../Components/LogNotificationCard"

const Dashboard = () => {
    const db = getFirestore(firebaseInstance)
    const [taskList, setTaskList] = useState<Task[]>([])
    const [logList, setLogList] = useState<Log[]>([])

    useEffect(() => {
        const unsubscribeTask = onSnapshot(
            collection(db, "task"),
            querySnapshot => {
                const tempTaskList: Task[] = []
                querySnapshot.forEach(doc => {
                    tempTaskList.push({
                        ...(doc.data() as Task),
                        id: doc.id,
                        dueDate: DateTime.fromSeconds(
                            doc.data().dueDate.seconds,
                        ),
                    })
                })

                setTaskList(tempTaskList)
            },
        )

        const unsubscribeLog = onSnapshot(
            collection(db, "log"),
            querySnapshot => {
                const tempLogList: Log[] = []
                querySnapshot.forEach(doc => {
                    tempLogList.push({
                        ...(doc.data() as Log),
                        id: doc.id,
                        timestamp: DateTime.fromSeconds(
                            doc.data().timestamp.seconds,
                        ),
                    })
                })
                setLogList(tempLogList)
            },
        )

        return () => {
            unsubscribeTask()
            unsubscribeLog()
        }
    }, [])

    useEffect(() => {
        console.log(taskList)
        console.log(logList)
    }, [taskList, logList])

    const getWorkingEngineers = (taskList: Task[]) => {
        const workingEngineers = [] as any[]
        const inProgressTasks = getInProgressTasks(taskList)
        inProgressTasks.filter(task => {
            if (!workingEngineers.includes(task.engineerId)) {
                workingEngineers.push(task.engineerId)
            }
        })
        return workingEngineers
    }

    const getTasksCompletedToday = (logList: Log[]) => {
        return logList.filter(log => {
            const diffInDays = log.timestamp.diffNow().as("days")

            return diffInDays < 0 && diffInDays > -1
        })
    }

    const getTasksCompletedWeek = (logList: Log[]) => {
        return logList.filter(log => {
            const diffInDays = log.timestamp.diffNow().as("days")

            return diffInDays < 0 && diffInDays > -7
        })
    }

    const getTasksCompletedMonth = (logList: Log[]) => {
        return logList.filter(log => {
            const diffInDays = log.timestamp.diffNow().as("days")

            return diffInDays < 0 && diffInDays > -30
        })
    }

    const getOverdueTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.dueDate.diffNow().as("days") < 0
        })
    }

    const getMaintenanceEquipments = (taskList: Task[]) => {
        const maintenanceEquipment = [] as any[]
        const inProgressTasks = getInProgressTasks(taskList)
        inProgressTasks.filter(task => {
            if (!maintenanceEquipment.includes(task.equipmentId)) {
                maintenanceEquipment.push(task.equipmentId)
            }
        })
        return maintenanceEquipment
    }

    const getInProgressTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.status === "In Progress"
        })
    }

    const getHighPriorityTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.priority === 3
        })
    }

    const getMediumPriorityTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.priority === 2
        })
    }

    const getLowPriorityTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.priority === 1
        })
    }

    return (
        <HStack w="full" maxWidth="1500px" spacing="50px">
            <Box w="full" maxWidth="1000px">
                <Heading mb="32px">At a Glance</Heading>
                <HStack maxWidth="1000px" spacing="25px">
                    <Box
                        border="2px"
                        h="min-content"
                        maxHeight="80vh"
                        w="full"
                        maxWidth="300px"
                        borderRadius="xl"
                        pb="20px">
                        <VStack
                            spacing="16px"
                            divider={
                                <Divider
                                    border="1px"
                                    borderColor="blackAlpha.900"
                                    maxWidth="250px"
                                />
                            }>
                            <Heading size="lg" pt="20px">
                                Engineer
                            </Heading>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getWorkingEngineers(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Working on Tasks
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getTasksCompletedToday(logList).length}{" "}
                                    Tasks
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Completed Today
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getTasksCompletedWeek(logList).length}{" "}
                                    Tasks
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Completed This Week
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getTasksCompletedMonth(logList).length}{" "}
                                    Tasks
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Completed This Month
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                        </VStack>
                    </Box>
                    <Box
                        border="2px"
                        h="min-content"
                        maxHeight="80vh"
                        w="full"
                        maxWidth="300px"
                        borderRadius="xl"
                        pb="20px">
                        <VStack
                            spacing="16px"
                            divider={
                                <Divider
                                    border="1px"
                                    borderColor="blackAlpha.900"
                                    maxWidth="250px"
                                />
                            }>
                            <Heading size="lg" pt="20px">
                                Equipment
                            </Heading>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getOverdueTasks(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Overdue Tasks
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getMaintenanceEquipments(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    In Maintenance
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                        </VStack>
                    </Box>
                    <Box
                        border="2px"
                        h="min-content"
                        maxHeight="80vh"
                        w="full"
                        maxWidth="300px"
                        borderRadius="xl"
                        pb="20px">
                        <VStack
                            spacing="16px"
                            divider={
                                <Divider
                                    border="1px"
                                    borderColor="blackAlpha.900"
                                    maxWidth="250px"
                                />
                            }>
                            <Heading size="lg" pt="20px">
                                Tasks
                            </Heading>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getInProgressTasks(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    In Progress
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getHighPriorityTasks(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    High Priority
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getMediumPriorityTasks(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Medium Priority
                                </StatHelpText>
                            </Stat>

                            <Stat>
                                <StatNumber textAlign="center">
                                    {getLowPriorityTasks(taskList).length}
                                </StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    Low Priority
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                            <Stat>
                                <StatNumber textAlign="center">...</StatNumber>
                                <StatHelpText
                                    fontSize="lg"
                                    textColor="black"
                                    textAlign="center">
                                    ...
                                </StatHelpText>
                            </Stat>
                        </VStack>
                    </Box>
                </HStack>
            </Box>
            <Box>
                <Heading mb="32px">Recent Logs</Heading>
                <VStack
                    h="min-content"
                    maxHeight="80vh"
                    w="100%"
                    maxWidth="500px"
                    pb="20px"
                    overflow="hidden">
                    <LogNotificationCard
                        title="Routine Inspection"
                        engineerName="Nasrullah"
                        type="Cancelled"
                        timestamp={DateTime.now()}
                    />
                    <LogNotificationCard
                        title="Routine Inspection"
                        engineerName="Nasrullah"
                        type="Completed"
                        timestamp={DateTime.now()}
                    />
                </VStack>
            </Box>
        </HStack>
    )
}

export default Dashboard
