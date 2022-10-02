import { Box, Heading, HStack, VStack, Text, Icon } from "@chakra-ui/react"
import { DateTime } from "luxon"
import { IoCalendarClear, IoPerson, IoChevronForward } from "react-icons/io5"
import React from "react"
import { Log } from "../Interfaces/Log"

type LogNotificationCardProps = {
    title: string
    type: "Cancelled" | "Completed"
    engineerName: string
    timestamp: DateTime
}

const LogNotificationCard = (props: LogNotificationCardProps) => {
    return (
        <HStack
            _hover={{
                borderColor:
                    props.type === "Cancelled"
                        ? "rgba(255, 77, 77)"
                        : "rgba(75, 210, 143)",
                cursor: "pointer",
            }}
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
    )
}

export default LogNotificationCard
