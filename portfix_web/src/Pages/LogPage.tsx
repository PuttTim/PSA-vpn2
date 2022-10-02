import {
    Box,
    Heading,
    Table,
    Thead,
    Tbody,
    Tfoot,
    Tr,
    Th,
    Td,
    TableCaption,
    TableContainer,
} from "@chakra-ui/react"
import { collection, getFirestore, onSnapshot } from "firebase/firestore"
import { DateTime } from "luxon"
import React, { useEffect, useState } from "react"
import StatusLight from "../Components/StatusLight"
import firebaseInstance from "../firebase"
import { Engineer } from "../Interfaces/Engineer"
import { Log } from "../Interfaces/Log"

const LogPage = () => {
    const db = getFirestore(firebaseInstance)
    const [engineerList, setEngineerList] = useState<Engineer[]>([])
    const [logList, setLogList] = useState<Log[]>([])

    useEffect(() => {
        const unsubscribeEngineer = onSnapshot(
            collection(db, "engineer"),
            querySnapshot => {
                const tempEngineerList: Engineer[] = []
                querySnapshot.forEach(doc => {
                    tempEngineerList.push({
                        ...(doc.data() as Engineer),
                        id: doc.id,
                    })
                })

                setEngineerList(tempEngineerList)
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
            unsubscribeEngineer()
            unsubscribeLog()
        }
    }, [])

    useEffect(() => {
        console.log(engineerList)
        console.log(logList)
    }, [engineerList, logList])

    const getMostRecentLogs = (logList: Log[]) => {
        return logList.sort((a, b) => {
            return b.timestamp.diff(a.timestamp).as("seconds")
        })
    }

    const getEngineerById = (engineerId: string) => {
        return engineerList.find(engineer => {
            return engineer.id === engineerId
        })
    }

    return (
        <Box w="full" h="full">
            <Heading mb="32px">All Logs</Heading>
            <TableContainer w="full" h="full" pb="32px">
                <Table w="full" h="full" variant="simple">
                    <Thead>
                        <Tr>
                            <Th>Status</Th>
                            <Th>Title</Th>
                            <Th>Engineer</Th>
                            <Th>Equipment ID</Th>
                            <Th>Log Submitted On</Th>
                            <Th>Comment</Th>
                        </Tr>
                    </Thead>
                    <Tbody>
                        {getMostRecentLogs(logList).map(log => (
                            <Tr key={log.id}>
                                <Td textAlign="center">
                                    <StatusLight
                                        color={
                                            log.type === "Completed"
                                                ? "green"
                                                : "red"
                                        }
                                    />
                                </Td>
                                <Td>{log.title}</Td>
                                <Td>
                                    {getEngineerById(log.engineerId)?.name ??
                                        "Unknown"}
                                </Td>
                                <Td>{log.equipmentId}</Td>
                                <Td>
                                    {log.timestamp.toFormat(
                                        "yyyy/MM/dd @ HH:mm:ss ZZZZ",
                                    )}
                                </Td>
                                <Td>{log.comment}</Td>
                            </Tr>
                        ))}
                    </Tbody>
                </Table>
            </TableContainer>
        </Box>
    )
}

export default LogPage
