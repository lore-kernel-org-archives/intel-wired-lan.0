From: Roland Dreier <roland@purestorage.com>
Date: Mon, 17 Jul 2017 13:47:57 -0700
Subject: [Intel-wired-lan] Device isolation for X550 functions
Message-ID: <CAL1RGDW0ThAtTR-o_RUCmrKBAEM_a2wDLG7=2HRV5McRNa0DyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi ixgbe maintainers -

We've been trying to do passthrough of X550 VFs to a KVM virtual
machine for our application, and we noticed that the kernel does not
put the different functions in different iommu groups the same way it
does for X520.  This is because the kernel change that enabled
appropriate ACS bits for X520 does not include the X550 device ID
(1563h in our case):

    commit 100ebb2c48ea
    Author: Alex Williamson <alex.williamson@redhat.com>
    Date:   Fri Sep 26 16:07:59 2014

    PCI: Add ACS quirk for Intel 10G NICs

    Intel has verified there is no peer-to-peer between functions for the below
    selection of 82598, 82599, and X520 10G NICs.  These NICs lack an ACS
    capability, so we're not able to determine this isolation without the help
    of quirks.

    Generalize the Solarflare quirk and add these Intel 10G NICs.

I'd like to send the patch below upstream, which adds all the device
IDs from the ixgbe driver that seem like they should be included in
the quirk, but aren't yet.  I'm hypothesizing that X540 and X550 are
pretty close variants of the X520 except for the PHY, and so adding
them to the quirk table is OK.

Can you please check internally in Intel to make sure the extending
the quirk to all ixgbe devices is correct?  If so I will send this
patch to the appropriate mailing lists for you guys to merge upstream.

Thanks!
  Roland

From: Roland Dreier <roland@purestorage.com>
Date: Thu, 1 Jun 2017 10:45:22 -0700
Subject: [PATCH] PCI: Update ACS quirk for more Intel 10G NICs

Add one more variant of the 82599 plus the device IDs for X540 and X550
variants.  None of these devices do peer-to-peer between functions.

Signed-off-by: Roland Dreier <roland@purestorage.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb787aa9e..a51b85878f35 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4318,12 +4318,33 @@ static const struct pci_dev_acs_enabled {
     { PCI_VENDOR_ID_INTEL, 0x1507, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x1514, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x151C, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x1528, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x1529, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x154A, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x152A, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x154D, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x154F, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x1551, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x1558, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x1560, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x1563, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AA, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AB, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AC, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AD, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AE, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15B0, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15AB, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C2, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C3, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C4, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C6, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C7, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15C8, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15CE, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15E4, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15E5, pci_quirk_mf_endpoint_acs },
+    { PCI_VENDOR_ID_INTEL, 0x15D1, pci_quirk_mf_endpoint_acs },
     /* 82580 */
     { PCI_VENDOR_ID_INTEL, 0x1509, pci_quirk_mf_endpoint_acs },
     { PCI_VENDOR_ID_INTEL, 0x150E, pci_quirk_mf_endpoint_acs },
