#Create sharded mongodb cluster in 3 zones
#Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster

resource "yandex_mdb_mongodb_cluster" "foo" {
  name        = "test"
  environment = "PRODUCTION" //PRESTABLE or PRODUCTION
  network_id  = var.default_network_id

  cluster_config {
    version = "4.2" //version of the cluster
  }

  labels = {
    test_key = "test_value"
  }

  database {
    name = "testdb"
  }

  user {
    name     = "john"
    password = "password"
    permission {
      database_name = "testdb"
    }
  }

  resources {
    resource_preset_id = "s2.micro" //resource_preset_id - types are in the official documentation
    disk_size          = 16 //disk size
    disk_type_id       = "network-hdd" //disk_type_id - types are in the official documentation
  }

  host {
    zone_id   = "ru-central1-a"
    subnet_id = var.default_subnet_id_zone_a
    shard_name = "newshard" //The name of the shard to which the host belongs
    assign_public_ip = true //Should this host have assigned public IP assigned - true or false
    type = "mongod" //type of mongo daemon which runs on this host (mongod, mongos or monogcfg)
  }

  host {
    zone_id   = "ru-central1-b"
    subnet_id = var.default_subnet_id_zone_b
    shard_name = "newshard" //The name of the shard to which the host belongs
    assign_public_ip = true //Should this host have assigned public IP assigned - true or false
    type = "mongod" //type of mongo daemon which runs on this host (mongod, mongos or monogcfg)
  }

  host {
    zone_id   = "ru-central1-c"
    subnet_id = var.default_subnet_id_zone_c
    shard_name = "newshard" //The name of the shard to which the host belongs
    assign_public_ip = true //Should this host have assigned public IP assigned - true or false
    type = "mongod" //type of mongo daemon which runs on this host (mongod, mongos or monogcfg)
  }

  maintenance_window {
    type = "ANYTIME"
  }
}
