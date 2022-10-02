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

const Dashboard = () => {
    const db = getFirestore(firebaseInstance)
    const [equipmentList, setEquipmentList] = useState<Equipment[]>([])
    const [taskList, setTaskList] = useState<Task[]>([])
    const [logList, setLogList] = useState<Log[]>([])

    // useEffect(() => {
    //     const unsubscribeTask = onSnapshot(
    //         collection(db, "task"),
    //         querySnapshot => {
    //             const tempTaskList: Task[] = []
    //             querySnapshot.forEach(doc => {
    //                 tempTaskList.push({
    //                     ...(doc.data() as Task),
    //                     id: doc.id,
    //                 })
    //             })

    //             setTaskList(tempTaskList)
    //         },
    //     )
    //     const unsubscribeEquipment = onSnapshot(
    //         collection(db, "equipment"),
    //         querySnapshot => {
    //             const tempEquipmentList: Equipment[] = []
    //             querySnapshot.forEach(doc => {
    //                 tempEquipmentList.push({
    //                     ...(doc.data() as Equipment),
    //                     id: doc.id,
    //                 })
    //             })
    //             setEquipmentList(tempEquipmentList)
    //         },
    //     )

    //     const unsubscribeLog = onSnapshot(
    //         collection(db, "log"),
    //         querySnapshot => {
    //             const tempLogList: Log[] = []
    //             querySnapshot.forEach(doc => {
    //                 tempLogList.push({
    //                     ...(doc.data() as Log),
    //                     id: doc.id,
    //                 })
    //             })
    //             setLogList(tempLogList)
    //         },
    //     )

    //     return () => {
    //         unsubscribeTask()
    //         unsubscribeEquipment()
    //         unsubscribeLog()
    //     }
    // }, [])

    useEffect(() => {
        console.log(equipmentList)
        console.log(taskList)
        console.log(logList)
    }, [equipmentList, taskList, logList])

    return (
        <Box w="full">
            <HStack spacing="900px" mb="32px">
                <Heading>At a Glance</Heading>
                <Heading>Notifications</Heading>
            </HStack>

            <HStack maxWidth="1000px" spacing="25px">
                <Box
                    border="2px"
                    h="500px"
                    maxHeight="500px"
                    w="full"
                    maxWidth="300px"
                    borderRadius="xl"
                    pb="20px">
                    <VStack
                        spacing="16px"
                        divider={
                            <Divider
                                border="2px"
                                borderColor="blackAlpha.900"
                                maxWidth="250px"
                            />
                        }>
                        <Heading size="lg" pt="20px">
                            Engineer
                        </Heading>

                        <Stat>
                            <StatNumber textAlign="center">10/15</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Working on Tasks
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">10 Tasks</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Completed Today
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">
                                250 Tasks
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
                                1000 Tasks
                            </StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Completed This Month
                            </StatHelpText>
                        </Stat>
                    </VStack>
                </Box>
                <Box
                    border="2px"
                    h="500px"
                    maxHeight="500px"
                    w="full"
                    maxWidth="300px"
                    borderRadius="xl"
                    pb="20px">
                    <VStack
                        spacing="16px"
                        divider={
                            <Divider
                                border="2px"
                                borderColor="blackAlpha.900"
                                maxWidth="250px"
                            />
                        }>
                        <Heading size="lg" pt="20px">
                            Equipment
                        </Heading>

                        <Stat>
                            <StatNumber textAlign="center">2</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Overdue Tasks
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">4</StatNumber>
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
                    </VStack>
                </Box>
                <Box
                    border="2px"
                    h="500px"
                    maxHeight="500px"
                    w="full"
                    maxWidth="300px"
                    borderRadius="xl"
                    pb="20px">
                    <VStack
                        spacing="16px"
                        divider={
                            <Divider
                                border="2px"
                                borderColor="blackAlpha.900"
                                maxWidth="250px"
                            />
                        }>
                        <Heading size="lg" pt="20px">
                            Tasks
                        </Heading>

                        <Stat>
                            <StatNumber textAlign="center">23</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                In Progress
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">4</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                High Priority
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">15</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Medium Priority
                            </StatHelpText>
                        </Stat>

                        <Stat>
                            <StatNumber textAlign="center">25</StatNumber>
                            <StatHelpText
                                fontSize="lg"
                                textColor="black"
                                textAlign="center">
                                Low Priority
                            </StatHelpText>
                        </Stat>
                    </VStack>
                </Box>
            </HStack>
        </Box>
    )
}

export default Dashboard
