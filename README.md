```mermaid
erDiagram
    parkinglots_details {
        int parkinglot_id PK "Parking Lot ID (Primary Key)"
        text parking_name
        text city
        text landmark
        text address
        numeric latitude
        numeric longitude
        text physical_appearance
        text parking_ownership
        text parking_surface
        text has_cctv
        text has_boom_barrier
        text ticket_generated
        text entry_exit_gates
        text weekly_off
        text parking_timing
        text vehicle_types
        int car_capacity
        int available_car_slots
        int two_wheeler_capacity
        int available_two_wheeler_slots
        text parking_type
        text payment_modes
        text car_parking_charge
        text two_wheeler_parking_charge
        text allows_prepaid_passes
        text provides_valet_services
        text value_added_services
    }

    floors {
        int parkinglot_id PK, FK "Parking Lot ID (Composite PK, Foreign Key)"
        int floor_id PK "Floor ID (Composite PK)"
        varchar floor_name
    }

    rows {
        int parkinglot_id PK, FK "Parking Lot ID (Composite PK, Foreign Key)"
        int floor_id PK, FK "Floor ID (Composite PK, Foreign Key)"
        int row_id PK "Row ID (Composite PK)"
        varchar row_name
    }

    slots {
        int parkinglot_id PK, FK "Parking Lot ID (Composite PK, Foreign Key)"
        int floor_id PK, FK "Floor ID (Composite PK, Foreign Key)"
        int row_id PK, FK "Row ID (Composite PK, Foreign Key)"
        int slot_id PK "Slot ID (Composite PK)"
        varchar slot_name
        int status "0=Free, 1=Occupied"
        varchar vehicle_reg_no "(Nullable)"
        varchar ticket_id FK "(Nullable) Current Ticket ID"
    }

    users {
        int user_id PK "User ID (Primary Key, Auto-increment)"
        varchar user_name
        varchar user_email
        varchar user_password "Hashed password"
        varchar user_phone_no
        text user_address "(Nullable)"
    }

    parking_sessions {
        varchar ticket_id PK "Ticket ID (Primary Key)"
        int parkinglot_id FK "(Nullable) Parking Lot ID (Foreign Key)"
        int floor_id FK "(Nullable) Floor ID (Foreign Key)"
        int row_id FK "(Nullable) Row ID (Foreign Key)"
        int slot_id FK "(Nullable) Slot ID (Foreign Key)"
        varchar vehicle_reg_no
        int user_id FK "(Nullable) User ID (Foreign Key)"
        timestamp start_time
        timestamp end_time "(Nullable)"
        numeric duration_hrs "Generated Column"
    }

    parkinglots_details ||--o{ floors : "has"
    floors ||--o{ rows : "contains"
    rows ||--o{ slots : "contains"
    users ||--o{ parking_sessions : "initiates"
    slots ||--o{ parking_sessions : "hosts"
    slots }o--|| parking_sessions : "currently occupied by (via ticket_id)"
