From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:35:57 +0000
Subject: [Intel-wired-lan] [PATCH v1 4/9] fm10k: do not disable PCI
 device	in fm10k_io_error_detected
In-Reply-To: <1459552659-22959-5-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371469@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 4/9] fm10k: do not disable PCI device in fm10k_io_error_detected

fm10k_io_error_detected() does not need to call pci_disable_device(). In the cases where the reset needs to occur, the stack flow will result in calling fm10k_remove() which already disables the PCI device. If we leave the pci_disable_device(), we result in a warning about disabling an already disabled device.

Many PCI drivers do call pci_disable_device() in their .error_detected() routines, but it does not appear to be required. In addition, these drivers have a check "is_pci_enabled()" call in their remove routines, which is how they chose to handle the duplicate device disable.

This seems incorrect, since the PCI device structure is reference counted. It is very possible that the reference count for the PCI device could be greater than 1. In this case, you would remove the PCI device within the error_detected routine, reducing count to 1, then remove it again in the remove function, reducing it to zero. This would result in yet another disable somewhere else failing. Thus, we shouldn't be using
is_pci_enabled() to check for this issue. Instead, just remove the extraneous pci_device_disable() found within the error_detected routine.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


