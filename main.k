api_gateway = {
    name = "API Gateway"
    owner = "platform-team"
    metadata = {
        language = "go"
        port = "8080"
    }
    dependencies = [
        {target = "user_service", type = "grpc", metadata = {port = "9090"}}
        {target = "order_service", type = "grpc", metadata = {port = "9091"}}
        {target = "notification_service", type = "grpc", metadata = {port = "9092"}}
        {
            target = "auth_service"
            type = "grpc"
            metadata = {
                port = "9100"
            }
        }
        {
            target = "redis_cache"
            type = "redis"
            metadata = {
                purpose = "session-store"
            }
        }
    ]
}

user_service = {
    name = "User Service"
    owner = "identity-and-auth-team"
    metadata = {
        language = "go"
        port = "9090"
    }
    dependencies = [
        {target = "postgres_db", type = "postgres", metadata = {database = "users"}}
    ]
}

order_service = {
    name = "Order Service"
    owner = "orders-team"
    metadata = {
        language = "python"
        port = "9091"
    }
    dependencies = [
        {target = "postgres_db", type = "postgres", metadata = {database = "orders"}}
        {target = "kafka_broker", type = "kafka", metadata = {topic = "order-events"}}
        {target = "notification_service", type = "grpc", metadata = {port = "9092"}}
    ]
}

notification_service = {
    name = "Notification Service"
    owner = "comms-team"
    metadata = {
        language = "go"
        port = "9092"
    }
    dependencies = [
        {target = "kafka_broker", type = "kafka", metadata = {topic = "notifications"}}
    ]
}

postgres_db = {
    name = "PostgreSQL"
    owner = "dba-team"
    metadata = {
        version = "16"
        engine = "postgresql"
    }
    dependencies += [
        {
            target = "test"
            type = "postgres"
        }
        {
            target = "test_srv"
            type = "postgres"
        }
    ]
}

kafka_broker = {
    name = "Kafka Broker"
    owner = "platform-team"
    metadata = {
        version = "3.6"
        cluster = "main"
    }
    dependencies += [
        {
            target = "payment_service"
            type = "kafka"
        }
    ]
}
auth_service = {
    name = "Auth Service"
    owner = "identity-team"
    metadata = {
        language = "rust"
        port = "9100"
    }
    dependencies += [
        {
            target = "postgres_db"
            type = "postgres"
            metadata = {
                database = "auth"
            }
        }
    ]
}

payment_service = {
    name = "Payment Service"
    owner = "payments-team"
    metadata = {
        language = "go"
        port = "9200"
    }
    dependencies = [
        {target = "postgres_db", type = "postgres", metadata = {database = "payments"}}
        {
            target = "billing_service"
            type = "grpc"
        }
    ]
}

redis_cache = {
    name = "Redis Cache"
    owner = "platform-team"
    metadata = {
        mode = "cluster"
        version = "7.2"
    }
}

billing_service = {
    name = "Billing Service"
    owner = "billing-team"
    dependencies += [
        {
            target = "postgres_db"
            type = "postgres"
        }
    ]
}
