import { GeoPoint } from "@google-cloud/firestore"

export interface Equipment {
    id: string
    model: string
    location: string
    geopoint: GeoPoint
}
