import {
    Box,
    Container,
    Heading,
    HStack,
    IconButton,
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
import { useState } from "react"
import { IoAdd, IoInformation } from "react-icons/io5"
import { Equipment } from "../Interfaces/Equipment"

type DataTableProps = {
    heading: string[]
    equipment: Equipment[]
    onSelect: (id: string) => void
    onAdd: () => void
}

const EquipmentTable = (props: DataTableProps) => {
    const { isOpen, onOpen, onClose } = useDisclosure()

    return (
        <>
            <Container
                h="full"
                maxH="100%"
                maxW="full"
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
                                        }>
                                        <Td>!!!</Td>
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
                    <ModalBody>TODO</ModalBody> {/*TODO Add form*/}
                    <ModalFooter />
                </ModalContent>
            </Modal>
        </>
    )
}

export default EquipmentTable
