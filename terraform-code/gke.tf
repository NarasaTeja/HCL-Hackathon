resource "google_container_cluster" "hackathon_cluster" {
  name               = "gke-cluster"
  location           = var.region
  initial_node_count = 1
  remove_default_node_pool = true

  network    = google_compute_network.base_vpc.name
  subnetwork = google_compute_subnetwork.private_subnet_1.name

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/14"
    services_ipv4_cidr_block = "/20"
  }

  service_account = google_service_account.service_account.id

  # Optional: Enable master authorized networks, logging, monitoring etc.
}

# data "google_container_cluster" "hackathon_cluster" {
#   name     = "cluster-1"
#   location = var.region
# }

resource "google_container_node_pool" "hackathon_np" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.hackathon_cluster.name
  location   = var.region
  node_count = 2

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
