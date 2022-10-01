import { GeoPoint } from "@google-cloud/firestore"

export interface Equipment {
    id: String
    model: String
    location: String
    geopoint: GeoPoint
}
