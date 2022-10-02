import {
    Box,
    Button,
    Center,
    Container,
    FormControl,
    FormHelperText,
    FormLabel,
    Heading,
    HStack,
    IconButton,
    Input,
    Modal,
    ModalBody,
    ModalCloseButton,
    ModalContent,
    ModalFooter,
    ModalHeader,
    ModalOverlay,
    Table,
    TableContainer,
    Tbody,
    Td,
    Th,
    Thead,
    Tr,
    useDisclosure,
    VStack,
} from "@chakra-ui/react"
import { doc, GeoPoint, getFirestore, setDoc } from "firebase/firestore"
import { useEffect, useState } from "react"
import { IoAdd, IoInformation } from "react-icons/io5"
import firebaseInstance from "../firebase"
import { Equipment } from "../Interfaces/Equipment"
import StatusLight from "./StatusLight"

type EquipmentTableProps = {
    heading: string[]
    equipment: Equipment[]
    maintenanceEquipment: string[]
    selectedEquipmentId: string
    onSelect: (id: string) => void
    onAdd: () => void
}

const EquipmentTable = (props: EquipmentTableProps) => {
    const db = getFirestore(firebaseInstance)

    const { isOpen, onOpen, onClose } = useDisclosure()

    const [equipmentForm, setEquipmentForm] = useState({
        id: "",
        model: "",
        location: "",
        lat: 0,
        lon: 0,
    })

    const addEquipment = () => {
        setDoc(doc(db, "equipment", equipmentForm.id), {
            model: equipmentForm.model,
            location: equipmentForm.location,
            geopoint: new GeoPoint(equipmentForm.lat, equipmentForm.lon),
        })
        onClose()
    }

    return (
        <>
            <Container
                h="full"
                maxH="100%"
                maxW="52vw"
                minW="52vw"
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
                        <Heading size="lg">Equipment</Heading>

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
                                {props.equipment.map((equipment, index) => (
                                    <Tr
                                        key={index}
                                        onClick={() =>
                                            props.onSelect(equipment.id)
                                        }
                                        cursor="pointer"
                                        bgColor={
                                            equipment.id ===
                                            props.selectedEquipmentId
                                                ? "hsla(187, 71%, 61%, 15%)"
                                                : "hsla(187, 71%, 61%, 0%)"
                                        }
                                        transition="background-color 0.2s ease-out">
                                        <Td>
                                            <Center>
                                                <StatusLight
                                                    color={
                                                        props.maintenanceEquipment.includes(
                                                            equipment.id,
                                                        )
                                                            ? "redPulse"
                                                            : "green"
                                                    }
                                                />
                                            </Center>
                                        </Td>
                                        <Td>{equipment.id}</Td>
                                        <Td>{equipment.model}</Td>
                                        <Td>{equipment.location}</Td>
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
                    <ModalHeader>Add New Equipment</ModalHeader>
                    <ModalCloseButton />
                    <ModalBody>
                        <FormControl isRequired>
                            <FormLabel>Equipment Id</FormLabel>
                            <Input
                                type="text"
                                onChange={e =>
                                    setEquipmentForm({
                                        ...equipmentForm,
                                        id: e.target.value,
                                    })
                                }
                            />
                            <FormHelperText>
                                Eg. ARMG11, CR6, PM03
                            </FormHelperText>
                            <br />

                            <FormLabel>Model</FormLabel>
                            <Input
                                type="text"
                                onChange={e =>
                                    setEquipmentForm({
                                        ...equipmentForm,
                                        model: e.target.value,
                                    })
                                }
                            />
                            <FormHelperText>
                                Eg. Ship to shore container crane, Prime mover
                            </FormHelperText>
                            <br />

                            <FormLabel>Location</FormLabel>
                            <Input
                                type="text"
                                onChange={e =>
                                    setEquipmentForm({
                                        ...equipmentForm,
                                        location: e.target.value,
                                    })
                                }
                            />
                            <FormHelperText>Eg. PPT6</FormHelperText>
                            <br />

                            <FormLabel>
                                Geopoint (Latitude & Longitude)
                            </FormLabel>
                            <HStack>
                                <Input
                                    type="number"
                                    min="-90"
                                    max="90"
                                    placeholder="Latitude"
                                    onChange={e =>
                                        setEquipmentForm({
                                            ...equipmentForm,
                                            lat: e.target
                                                .value as unknown as number,
                                        })
                                    }
                                />
                                <Input
                                    type="number"
                                    min="-180"
                                    max="180"
                                    placeholder="Longitude"
                                    onChange={e =>
                                        setEquipmentForm({
                                            ...equipmentForm,
                                            lon: e.target
                                                .value as unknown as number,
                                        })
                                    }
                                />
                            </HStack>
                            <FormHelperText>
                                Eg. 1.26920 & 103.78640
                            </FormHelperText>
                        </FormControl>
                    </ModalBody>
                    <ModalFooter>
                        <Button
                            disabled={
                                equipmentForm.id === "" ||
                                equipmentForm.model === "" ||
                                equipmentForm.location === "" ||
                                equipmentForm.lat === 0 ||
                                equipmentForm.lon === 0
                            }
                            onClick={addEquipment}
                            colorScheme="teal">
                            Add Equipment
                        </Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </>
    )
}

export default EquipmentTable
