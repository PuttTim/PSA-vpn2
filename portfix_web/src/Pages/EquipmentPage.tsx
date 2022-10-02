import {
    Box,
    Grid,
    GridItem,
    HStack,
    Stat,
    StatLabel,
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
    const [taskList, setTaskList] = useState<Task[]>([])

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
                            return a.dueDate.diff(b.dueDate).as("days")
                        })
                        tempTaskList.sort((a, b) => {
                            return b.priority - a.priority
                        })
                        setTaskList(tempTaskList)
                    })
                })
            },
        )

        return () => {
            unsubscribeEquipment()
            unsubscribeTask()
        }
    }, [])

    const selectEquipment = (id: string) => {
        if (id === equipmentId) {
            setEquipmentId("0")
        } else {
            setEquipmentId(id)
        }
    }

    const addEquipment = () => {
        console.log("Add equipment")
    }

    const addTask = () => {
        console.log("Add task")
    }

    return (
        <Box w="full">
            <Grid
                h="full"
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
                        onSelect={selectEquipment}
                        onAdd={addEquipment}
                    />
                </GridItem>
                <GridItem rowSpan={2} colSpan={1}>
                    <Box border="2px" h="full">
                        {equipmentId}
                    </Box>
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
