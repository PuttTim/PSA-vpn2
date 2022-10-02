import {
    useDisclosure,
    Container,
    VStack,
    HStack,
    Heading,
    IconButton,
    TableContainer,
    Table,
    Thead,
    Tr,
    Th,
    Tbody,
    Td,
    Modal,
    ModalOverlay,
    ModalContent,
    ModalHeader,
    ModalCloseButton,
    ModalBody,
    ModalFooter,
    Box,
} from "@chakra-ui/react"
import { doc, getDoc, getFirestore } from "firebase/firestore"
import { DateTime } from "luxon"
import React, { useEffect } from "react"
import { IoAdd, IoInformation } from "react-icons/io5"
import firebaseInstance from "../firebase"
import { Task } from "../Interfaces/Task"

type TaskTableProps = {
    heading: string[]
    tasks: Task[]
    // onSelect: (id: string) => void
    onAdd: () => void
}

const TaskTable = (props: TaskTableProps) => {
    const db = getFirestore(firebaseInstance)

    const { isOpen, onOpen, onClose } = useDisclosure()
    const [engineerNameList, setEngineerNameList] = React.useState<string[]>([])

    return (
        <>
            <Container
                h="full"
                maxH="100%"
                maxW="40vw"
                minW="40vw"
                overflowY="scroll"
                outline="2.5px solid black"
                borderRadius="xl">
                <VStack alignItems="start">
                    <HStack
                        h="full"
                        w="full"
                        px={5}
                        py={3}
                        justifyContent="space-between">
                        <Heading size="lg">Tasks</Heading>
                        <IconButton
                            aria-label="Add new item"
                            icon={<IoAdd size="1.5em" />}
                            isRound={true}
                            variant="solid"
                            colorScheme="teal"
                            size="sm"
                            onClick={onOpen}
                        />
                    </HStack>
                    <TableContainer w="full">
                        <Table variant="simple" colorScheme="blackAlpha">
                            <Thead>
                                <Tr>
                                    {props.heading.map((heading, index) => (
                                        <Th key={index}>{heading}</Th>
                                    ))}
                                </Tr>
                            </Thead>
                            <Tbody>
                                {props.tasks.map((task, index) => (
                                    <Tr
                                        key={index}
                                        // onClick={() => props.onSelect(task.id)}
                                    >
                                        <Td>{task.priority}</Td>
                                        <Td>{task.status}</Td>
                                        <Td>{task.title}</Td>
                                        <Td
                                            maxW="15ch"
                                            overflowX="hidden"
                                            textOverflow="ellipsis">
                                            {task.engineerId}
                                        </Td>
                                        <Td>
                                            {task.dueDate
                                                ? task.dueDate.toFormat(
                                                      "dd/MM/yyyy",
                                                  )
                                                : "-/-/-"}
                                        </Td>
                                    </Tr>
                                ))}
                            </Tbody>
                        </Table>
                    </TableContainer>
                </VStack>
            </Container>

            <Modal isOpen={isOpen} onClose={onClose}>
                <ModalOverlay />
                <ModalContent>
                    <ModalHeader>Add New Task</ModalHeader>
                    <ModalCloseButton />
                    <ModalBody>TODO</ModalBody> {/*TODO Add form*/}
                    <ModalFooter />
                </ModalContent>
            </Modal>
        </>
    )
}

export default TaskTable
