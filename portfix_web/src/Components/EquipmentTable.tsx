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
import { GeoPoint } from "firebase/firestore"
import { useState } from "react"
import MapPicker from "react-google-map-picker"
import { IoAdd, IoInformation } from "react-icons/io5"
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

interface EquipmentForm {
    id: string
    model: string
    location: string
    geopoint: GeoPoint
}

const EquipmentTable = (props: EquipmentTableProps) => {
    const { isOpen, onOpen, onClose } = useDisclosure()

    const [equipmentForm, setEquipmentForm] = useState({
        id: "",
        model: "",
        location: "",
        geopoint: new GeoPoint(1, 2),
    })

    const [geopoint, setGeopoint] = useState<GeoPoint>(new GeoPoint(1, 2))

    const addEquipment = () => {
        console.log("bruh")
    }

    function handleChangeLocation(lat: number, lng: number) {
        const tempGeopoint = new GeoPoint(lat, lng)
        setGeopoint(tempGeopoint)
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
                                        <Td>
                                            <IconButton
                                                aria-label="More Info"
                                                icon={
                                                    <IoInformation size="1.5em" />
                                                }
                                                isRound={true}
                                            />
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
                            <FormLabel>Geopoint</FormLabel>
                            
                            <FormHelperText>
                                Drag and drop the pointer to the equipment's
                                location
                            </FormHelperText>
                        </FormControl>
                    </ModalBody>
                    <ModalFooter>
                        <Button
                            disabled={
                                equipmentForm.id === "" ||
                                equipmentForm.model === "" ||
                                equipmentForm.location === ""
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
