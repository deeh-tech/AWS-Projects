# AWS Secure S3 File-Sharing & Event Notification Pipeline

An event-driven cloud infrastructure project built on **Amazon Web Services (AWS)** to manage secure, restricted file ingestion for external media partners while providing automated, real-time administrative telemetry.

## 🚀 Project Overview
This project implements a secure, event-driven file-sharing architecture separating internal administrative monitoring from external vendor access. It leverages granular **IAM least-privilege security policies**, **Amazon S3 prefix-based partitioning**, and **Amazon Simple Notification Service (SNS)** topics to achieve real-time auditing and automated operational alerts whenever media assets are uploaded or removed.

---

## 🛠️ Architecture & Components
* **Storage Tier:** Amazon S3 bucket (`cafe-danbucket22`) configured with custom prefix routing (`images/`) to isolate shared media payloads.
* **IAM Security Boundaries:** 
  * A dedicated user group (`mediaco`) enforcing least-privilege access.
  * An external media user (`mediacouser`) granted restricted scoped permissions (`GetObject`, `PutObject`, `DeleteObject`) strictly within the designated folder prefix, while explicitly denying unauthorized bucket-level policy and permission modifications.
* **Event-Driven Messaging & Automation:** 
  * **Amazon SNS (`s3NotificationTopic`):** Manages real-time message distribution with a custom access policy permitting `s3.amazonaws.com` source actions.
  * **Email Subscriptions:** Direct protocol endpoints configured to deliver instant operational alerts upon object lifecycles.
* **Management Interface:** AWS Command Line Interface (`aws s3` and `aws s3api` toolsets) for rapid bucket provisioning, asset synchronization, and JSON-based event configuration deployments.

---

## ⚙️ Implementation Steps

### 1. S3 Bucket Provisioning & Asset Synchronization
Provision a unique private S3 bucket in `us-west-2` and synchronize sample media payloads into the target prefix:
* Create the S3 bucket (`cafe-danbucket22`) using the AWS CLI.
* Synchronize initial media files from local directories into the designated `images/` prefix.

### 2. IAM Least-Privilege Policy Configuration
Configure group-level permissions restricting third-party users exclusively to the target prefix via structured IAM JSON policies enforcing `GetObject`, `PutObject`, and `DeleteObject` operations, ensuring that external users cannot alter bucket-level configurations or object ACLs.

### 3. S3 Event Notification Configuration
Define object creation (`s3:ObjectCreated:*`) and deletion (`s3:ObjectRemoved:*`) triggers within an S3 notification JSON configuration file restricted to the `images/` prefix, and apply it using the AWS CLI `s3api` toolset to link the bucket directly to the `s3NotificationTopic` SNS topic.

---

## 🛡️ Security & Validation Outcomes
* **Access Control Enforcement:** Verified that external entities (`mediacouser`) successfully execute scoped object operations (`put`, `get`, `delete`) inside the `images/` folder of `cafe-danbucket22`.
* **Privilege Escalation Prevention:** Confirmed that unauthorized modifications (such as attempting to alter object ACLs via `put-object-acl` or changing bucket-level permissions) correctly trigger `AccessDenied` exceptions.
* **Automated Auditing:** Validated end-to-end message delivery via SNS, confirming instantaneous administrative visibility whenever files are uploaded or removed.
