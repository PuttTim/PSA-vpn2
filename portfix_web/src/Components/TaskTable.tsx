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
    Center,
    FormControl,
    FormHelperText,
    FormLabel,
    Input,
    Button,
    RadioGroup,
    Radio,
    InputGroup,
    InputRightAddon,
    InputLeftAddon,
    NumberInput,
    NumberInputField,
    NumberInputStepper,
    NumberIncrementStepper,
    NumberDecrementStepper,
    Select,
    Textarea,
} from "@chakra-ui/react"
import { Timestamp } from "@google-cloud/firestore"
import {
    getFirestore,
    collection,
    onSnapshot,
    doc,
    addDoc,
} from "firebase/firestore"
import { DateTime } from "luxon"
import React, { useEffect, useState } from "react"
import { IoAdd, IoInformation } from "react-icons/io5"
import firebaseInstance from "../firebase"
import { Engineer } from "../Interfaces/Engineer"
import { Equipment } from "../Interfaces/Equipment"
import { Task } from "../Interfaces/Task"
import StatusLight from "./StatusLight"

type TaskTableProps = {
    heading: string[]
    tasks: Task[]
    // onSelect: (id: string) => void
    onAdd: () => void
}

const TaskTable = (props: TaskTableProps) => {
    const db = getFirestore(firebaseInstance)

    const { isOpen, onOpen, onClose } = useDisclosure()
    const [engineerList, setEngineerList] = useState<Engineer[]>([])
    const [equipmentList, setEquipmentList] = useState<Equipment[]>([])

    const [taskForm, setTaskForm] = useState({
        title: "",
        status: "Not Started",
        dueDate: DateTime.now(),
        priority: 1,
        repeat: 0,
        equipmentId: "",
        engineerId: null as string | null,
        description: "",
    })

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

        return () => {
            unsubscribeEngineer()
            unsubscribeEquipment()
        }
    }, [])

    const addTask = () => {
        addDoc(collection(db, "task"), {
            title: taskForm.title,
            status: taskForm.status,
            dueDate: taskForm.dueDate.toJSDate(),
            priority: taskForm.priority,
            repeat: taskForm.repeat,
            equipmentId: taskForm.equipmentId,
            engineerId: taskForm.engineerId,
            description: taskForm.description,
        })

        console.log("bruh")

        console.log(taskForm, "finall")

        setTaskForm({
            title: "",
            status: "Not Started",
            dueDate: DateTime.now(),
            priority: 1,
            repeat: 0,
            equipmentId: "",
            engineerId: null as string | null,
            description: "",
        })

        onClose()
    }

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
                                {props.tasks.length > 0 ? (
                                    props.tasks.map((task, index) => (
                                        <Tr
                                            key={index}
                                            // onClick={() => props.onSelect(task.id)}
                                        >
                                            <Td>
                                                <Center>
                                                    <StatusLight
                                                        color={
                                                            task.dueDate <
                                                            DateTime.now()
                                                                ? "redPulse"
                                                                : task.priority ===
                                                                  3
                                                                ? "red"
                                                                : task.priority ===
                                                                  2
                                                                ? "yellow"
                                                                : "green"
                                                        }
                                                    />
                                                </Center>
                                            </Td>
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
                                    ))
                                ) : (
                                    <Tr>
                                        <Td textAlign="center" colSpan={5}>
                                            No tasks found
                                        </Td>
                                    </Tr>
                                )}
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
                    <ModalBody>
                        <FormControl isRequired>
                            <FormLabel>Title</FormLabel>
                            <Input
                                type="text"
                                onChange={e =>
                                    setTaskForm({
                                        ...taskForm,
                                        title: e.target.value,
                                    })
                                }
                            />
                            <FormHelperText>
                                Eg. Routine Maintenance
                            </FormHelperText>
                            <br />

                            <FormLabel>Due Date</FormLabel>
                            <Input
                                type="datetime-local"
                                min={DateTime.now().toISO()}
                                onChange={e =>
                                    setTaskForm({
                                        ...taskForm,
                                        dueDate: DateTime.fromISO(
                                            e.target.value,
                                        ),
                                    })
                                }
                            />
                            <FormHelperText />
                            <br />

                            <FormLabel>Priority</FormLabel>
                            <RadioGroup
                                onChange={e => {
                                    setTaskForm({
                                        ...taskForm,
                                        priority: parseInt(e),
                                    })
                                }}
                                value={taskForm.priority}>
                                <HStack>
                                    <Radio value={3}>High</Radio>
                                    <Radio value={2}>Medium</Radio>
                                    <Radio value={1}>Low</Radio>
                                </HStack>
                            </RadioGroup>
                            <FormHelperText />
                            <br />

                            <FormLabel>Repeated Task</FormLabel>
                            <InputGroup>
                                <InputLeftAddon children="Repeat every" />
                                <NumberInput
                                    min={0}
                                    onChange={valueString =>
                                        setTaskForm({
                                            ...taskForm,
                                            repeat: parseInt(valueString),
                                        })
                                    }
                                    value={taskForm.repeat}>
                                    <NumberInputField />
                                    <NumberInputStepper>
                                        <NumberIncrementStepper />
                                        <NumberDecrementStepper />
                                    </NumberInputStepper>
                                </NumberInput>
                                <InputRightAddon children="Days" />
                            </InputGroup>
                            <FormHelperText>
                                Eg. Repeat this task every 7 days
                            </FormHelperText>
                            <br />

                            <FormLabel>Equipment</FormLabel>
                            <Select
                                placeholder="Select Equipment"
                                onChange={e =>
                                    setTaskForm({
                                        ...taskForm,
                                        equipmentId: e.target.value,
                                    })
                                }>
                                {equipmentList.map((equipment, index) => (
                                    <option key={index} value={equipment.id}>
                                        {equipment.id}
                                    </option>
                                ))}
                            </Select>
                            <FormHelperText>Eg. CR4</FormHelperText>
                            <br />

                            <FormLabel requiredIndicator="">Engineer</FormLabel>
                            <Select
                                placeholder="Select Engineer"
                                onChange={e =>
                                    setTaskForm({
                                        ...taskForm,
                                        engineerId: e.target.value,
                                    })
                                }>
                                {engineerList.map((engineer, index) => (
                                    <option key={index} value={engineer.id}>
                                        {engineer.name}
                                    </option>
                                ))}
                            </Select>
                            <FormHelperText>Eg. Victor</FormHelperText>
                            <br />

                            <FormLabel>Description</FormLabel>
                            <Textarea
                                onChange={e =>
                                    setTaskForm({
                                        ...taskForm,
                                        description: e.target.value,
                                    })
                                }
                            />
                            <FormHelperText>
                                Eg. Check the around the equipment for anything
                                wrong
                            </FormHelperText>
                            <br />
                        </FormControl>
                    </ModalBody>
                    <ModalFooter>
                        <Button
                            disabled={
                                taskForm.title === "" ||
                                taskForm.dueDate === undefined ||
                                taskForm.equipmentId === "" ||
                                taskForm.description === ""
                            }
                            onClick={addTask}
                            colorScheme="teal">
                            Add Task
                        </Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </>
    )
}

export default TaskTable
