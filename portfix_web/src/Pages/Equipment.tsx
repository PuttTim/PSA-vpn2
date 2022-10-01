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
import { useState } from "react"
import EquipmentTable from "../Components/EquipmentTable"

const Equipment = () => {
    const [equipmentId, setEquipmentId] = useState("0")

    const selectEquipment = (id: string) => {
        if (id === equipmentId) {
            setEquipmentId("0")
        } else {
            setEquipmentId(id)
        }
    }

    return (
        <Box w="full">
            <Grid
                maxH="90vh"
                w="full"
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
                        equipment={[
                            {
                                id: "1",
                                model: "Model 1",
                                location: "Location 1",
                                geopoint: new GeoPoint(1, 1),
                            },
                            {
                                id: "2",
                                model: "Model 2",
                                location: "Location 2",
                                geopoint: new GeoPoint(1, 1),
                            },
                            {
                                id: "3",
                                model: "Model 3",
                                location: "Location 3",
                                geopoint: new GeoPoint(1, 1),
                            },
                        ]}
                        onSelect={selectEquipment}
                    />
                </GridItem>
                <GridItem rowSpan={2} colSpan={1}>
                    <Box border="2px" h="full">
                        {equipmentId}
                    </Box>
                </GridItem>
                <GridItem rowSpan={3} colSpan={1}></GridItem>
            </Grid>
        </Box>
    )
}

export default Equipment
