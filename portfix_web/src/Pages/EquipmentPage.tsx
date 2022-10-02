import {
    Box,
    Container,
    Grid,
    GridItem,
    HStack,
    Stat,
    StatGroup,
    StatHelpText,
    StatLabel,
    StatNumber,
    VStack,
} from "@chakra-ui/react"
import { GeoPoint } from "@google-cloud/firestore"
import {
    getFirestore,
    getDocs,
    collection,
    onSnapshot,
    getDoc,
    doc,
} from "firebase/firestore"
import { DateTime } from "luxon"
import { useEffect, useState } from "react"
import EquipmentTable from "../Components/EquipmentTable"
import TaskTable from "../Components/TaskTable"
import firebaseInstance from "../firebase"
import { Equipment } from "../Interfaces/Equipment"
import { Task } from "../Interfaces/Task"

const EquipmentPage = () => {
    const db = getFirestore(firebaseInstance)

    const [equipmentId, setEquipmentId] = useState("0")
    const [equipmentList, setEquipmentList] = useState<Equipment[]>([])
    const [maintenanceEquipment, setMaintenanceEquipment] = useState<string[]>(
        [],
    )
    const [taskList, setTaskList] = useState<Task[]>([])
    const [fullTaskList, setFullTaskList] = useState<Task[]>([])

    useEffect(() => {
        const unsubscribeEquipment = onSnapshot(
            collection(db, "equipment"),
            querySnapshot => {
                const tempEquipmentList: Equipment[] = []
                querySnapshot.forEach(doc => {
                    tempEquipmentList.push({
                        id: doc.id,
                        model: doc.data().model,
                        location: doc.data().location,
                        geopoint: doc.data().geopoint,
                    })
                })
                setEquipmentList(tempEquipmentList)
            },
        )

        const unsubscribeTask = onSnapshot(
            collection(db, "task"),
            querySnapshot => {
                const tempTaskList: Task[] = []
                querySnapshot.forEach(async document => {
                    getDoc(
                        doc(
                            db,
                            "engineer",
                            document.data().engineerId
                                ? document.data().engineerId
                                : "0",
                        ),
                    ).then(engineer => {
                        tempTaskList.push({
                            id: document.id,
                            equipmentId: document.data().equipmentId,
                            engineerId: engineer.exists()
                                ? engineer.data()!.name
                                : "Unassigned",
                            title: document.data().title,
                            description: document.data().description,
                            priority: document.data().priority,
                            status: document.data().status,
                            repeat: document.data().repeat,
                            dueDate: DateTime.fromSeconds(
                                document.data().dueDate.seconds,
                            ),
                        })
                        tempTaskList.sort((a, b) => {
                            return b.priority - a.priority
                        })
                        tempTaskList.sort((a, b) => {
                            return a.dueDate.diff(b.dueDate).as("minutes")
                        })

                        setTaskList(tempTaskList)
                        setFullTaskList(tempTaskList)
                    })
                })
            },
        )

        return () => {
            unsubscribeEquipment()
            unsubscribeTask()
        }
    }, [])

    useEffect(() => {
        setMaintenanceEquipment(getMaintenanceEquipment(taskList))
    }, [equipmentList, fullTaskList])

    useEffect(() => {
        if (equipmentId !== "0") {
            setTaskList(
                fullTaskList.filter(task => task.equipmentId === equipmentId),
            )
        } else {
            setTaskList(fullTaskList)
        }
    }, [equipmentId])

    const selectEquipment = (id: string) => {
        if (id === equipmentId) {
            setEquipmentId("0")
        } else {
            setEquipmentId(id)
        }

        console.log(id)
    }

    const addEquipment = () => {
        console.log("Add equipment")
    }

    const addTask = () => {
        console.log("Add task")
    }

    const getNumberOfOverdueTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.dueDate.diffNow().as("days") <= 0
        }).length
    }

    const getNumberOfInprogressTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.status === "In Progress"
        }).length
    }

    const getInProgressTasks = (taskList: Task[]) => {
        return taskList.filter(task => {
            return task.status === "In Progress"
        })
    }

    const getMaintenanceEquipment = (taskList: Task[]) => {
        const maintenanceEquipment: string[] = []
        const inProgressTasks = getInProgressTasks(taskList)
        inProgressTasks.filter(task => {
            if (!maintenanceEquipment.includes(task.equipmentId)) {
                maintenanceEquipment.push(task.equipmentId)
            }
        })

        return maintenanceEquipment
    }

    return (
        <Box w="full">
            <Grid
                maxH="85vh"
                w="full"
                alignItems="stretch"
                justifyContent="center"
                gridTemplateRows="repeat(5, 1fr)"
                gridTemplateColumns="repeat(2, 1fr)"
                gap={8}>
                <GridItem maxH="full" rowSpan={5} colSpan={1}>
                    <EquipmentTable
                        heading={[
                            "Status",
                            "Equipment",
                            "Model",
                            "Location",
                            "Info",
                        ]}
                        equipment={equipmentList}
                        selectedEquipmentId={equipmentId}
                        maintenanceEquipment={maintenanceEquipment}
                        onSelect={selectEquipment}
                        onAdd={addEquipment}
                    />
                </GridItem>
                <GridItem rowSpan={2} colSpan={1}>
                    <Container
                        h="full"
                        maxW="40vw"
                        minW="40vw"
                        p={8}
                        outline="2.5px solid black"
                        borderRadius="xl"
                        display="flex"
                        alignItems="center">
                        <StatGroup w="full" fontSize={24}>
                            <Stat size="lg">
                                <StatLabel>Overdue Tasks</StatLabel>
                                <StatNumber fontSize={38}>
                                    {getNumberOfOverdueTasks(taskList)}
                                </StatNumber>
                                <StatHelpText fontSize={16}>
                                    Tasks that are past the due date
                                </StatHelpText>
                            </Stat>
                            <Stat size="lg">
                                <StatLabel>In Progress</StatLabel>
                                <StatNumber fontSize={38}>
                                    {getNumberOfInprogressTasks(taskList)}
                                </StatNumber>
                                <StatHelpText fontSize={16}>
                                    Tasks that are currently being worked on
                                </StatHelpText>
                            </Stat>
                        </StatGroup>
                    </Container>
                </GridItem>
                <GridItem rowSpan={3} colSpan={1}>
                    <TaskTable
                        heading={[
                            "Priority",
                            "Status",
                            "Title",
                            "Engineer",
                            "Due date",
                        ]}
                        tasks={taskList}
                        onAdd={addTask}
                    />
                </GridItem>
            </Grid>
        </Box>
    )
}

export default EquipmentPage
