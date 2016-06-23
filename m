From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:32:53 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: fix PCI device enable_cnt leak
 in	.io_slot_reset
In-Reply-To: <20160609190203.19082-1-jacob.e.keller@intel.com>
References: <20160609190203.19082-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397FC9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 9, 2016 12:02 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: fix PCI device enable_cnt leak in .io_slot_reset

A previous patch removed the pci_disable_device() call in .io_error_detected. This call corresponded to a pci_enable_device_mem() call within .io_slot_reset handler. Change the call here to a pci_reenable_device() so that it does not increment and leak the enable_cnt reference count for the device. Without this change, VF devices may fail during an unbind/bind, and we'll never zero the reference counter for the pci_dev structure.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

