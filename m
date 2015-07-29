From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 29 Jul 2015 16:00:38 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve "initialized field
	overwritten" warnings
Message-ID: <20150729230038.55713.326.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Resolve warnings resulting from redundant initialization of the
get_bus_info field in the mac_ops_X550* structures.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b1a895a96640..eca8a29ea683 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2266,7 +2266,6 @@ static void ixgbe_set_source_address_pruning_X550(struct ixgbe_hw *hw,
 	.get_mac_addr			= &ixgbe_get_mac_addr_generic, \
 	.get_device_caps		= &ixgbe_get_device_caps_generic, \
 	.stop_adapter			= &ixgbe_stop_adapter_generic, \
-	.get_bus_info			= &ixgbe_get_bus_info_generic, \
 	.set_lan_id			= &ixgbe_set_lan_id_multi_port_pcie, \
 	.read_analog_reg8		= NULL, \
 	.write_analog_reg8		= NULL, \

