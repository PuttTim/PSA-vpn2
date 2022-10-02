import {
    Box,
    HStack,
    VStack,
    Text,
    Icon,
    Modal,
    ModalOverlay,
    ModalContent,
    ModalHeader,
    ModalFooter,
    ModalBody,
    ModalCloseButton,
    useDisclosure,
    Heading,
} from "@chakra-ui/react"
import { DateTime } from "luxon"
import { IoCalendarClear, IoPerson } from "react-icons/io5"

type LogNotificationCardProps = {
    title: string
    type: "Cancelled" | "Completed"
    engineerName: string
    equipmentId: string
    comment: string
    timestamp: DateTime
}

const LogNotificationCard = (props: LogNotificationCardProps) => {
    const { isOpen, onOpen, onClose } = useDisclosure()

    return (
        <>
            <HStack
                _hover={{
                    borderColor:
                        props.type === "Cancelled"
                            ? "rgba(255, 77, 77)"
                            : "rgba(75, 210, 143)",
                    cursor: "pointer",
                }}
                onClick={onOpen}
                transition="border-color 0.2s ease-out"
                border="2px"
                borderRadius="xl"
                overflow="hidden"
                w="500px"
                h="100px">
                <Box
                    h="full"
                    width="10%"
                    bgColor={
                        props.type === "Cancelled"
                            ? "rgba(255, 77, 77)"
                            : "rgba(75, 210, 143)"
                    }></Box>
                <VStack w="90%" alignItems="start" pr="0.5rem">
                    <Text fontSize="2xl" fontWeight="bold">
                        {props.title}
                    </Text>
                    <HStack w="full" justifyContent="space-between">
                        <HStack>
                            <Icon as={IoPerson} boxSize="24px" />
                            <Text fontSize="lg">{props.engineerName}</Text>
                        </HStack>
                        <HStack>
                            <Icon as={IoCalendarClear} boxSize="24px" />
                            <Text fontSize="lg">
                                {props.timestamp.toFormat("yyyy/MM/dd")}
                            </Text>
                        </HStack>
                    </HStack>
                </VStack>
            </HStack>
            <Modal isOpen={isOpen} onClose={onClose}>
                <ModalOverlay />
                <ModalContent>
                    <ModalHeader>
                        <Heading>{props.title}</Heading>
                    </ModalHeader>
                    <ModalCloseButton />
                    <ModalBody>
                        <VStack alignItems="start" spacing="16px">
                            <VStack alignItems="start" spacing="8px">
                                <Heading fontSize="2xl">Engineer</Heading>
                                <Text fontSize="lg">{props.engineerName}</Text>
                            </VStack>
                            <VStack alignItems="start" spacing="8px">
                                <Heading fontSize="2xl">
                                    Equipment Name (ID)
                                </Heading>
                                <Text fontSize="lg">{props.equipmentId}</Text>
                            </VStack>
                            <VStack alignItems="start" spacing="8px">
                                <Heading fontSize="2xl">
                                    Equipment Status
                                </Heading>
                                <Text fontSize="lg">{props.type}</Text>
                            </VStack>
                            <VStack alignItems="start" spacing="8px">
                                <Heading fontSize="2xl">
                                    Log Submitted On
                                </Heading>
                                <Text fontSize="lg">
                                    {props.timestamp.toFormat(
                                        "yyyy/MM/dd @ HH:mm:ss ZZZZ",
                                    )}
                                </Text>
                            </VStack>
                            <VStack alignItems="start" spacing="8px">
                                <Heading fontSize="2xl">
                                    Engineer's Comment
                                </Heading>
                                <Text fontSize="lg">{props.comment}</Text>
                            </VStack>
                        </VStack>
                    </ModalBody>

                    <ModalFooter />
                </ModalContent>
            </Modal>
        </>
    )
}

export default LogNotificationCard
