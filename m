From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Thu, 18 Jun 2015 16:31:42 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remove unused PCI bus
	types
Message-ID: <20150618203142.5055.31733.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe never has as very doubtfully ever will support either
PCI or PCI-X devices.  So remove the unused types from the
ixgbe_bus_type.  Thanks to Alex Duyck for suggesting this.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 37df15f..1c5a5b3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3064,8 +3064,6 @@ enum ixgbe_smart_speed {
 /* PCI bus types */
 enum ixgbe_bus_type {
 	ixgbe_bus_type_unknown = 0,
-	ixgbe_bus_type_pci,
-	ixgbe_bus_type_pcix,
 	ixgbe_bus_type_pci_express,
 	ixgbe_bus_type_internal,
 	ixgbe_bus_type_reserved

