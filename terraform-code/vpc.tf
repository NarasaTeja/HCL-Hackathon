


resource "google_compute_network" "base_vpc" {
  project                 = var.project
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "public_subnet_1" {
  name          = "public-subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.base_vpc.id
  private_ip_google_access = false
}


resource "google_compute_subnetwork" "private_subnet_1" {
  name                    = "private-subnet-1"
  ip_cidr_range           = "10.0.101.0/24"
  region                  = var.region
  network                 = google_compute_network.base_vpc.id
  private_ip_google_access = true
}


provider "google" {
  project = var.project
  region  = "europe-west1"
  zone    = "europe-west1-b"
}




