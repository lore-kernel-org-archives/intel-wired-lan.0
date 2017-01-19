From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 19 Jan 2017 15:55:12 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: add default setup_link for
	x550em_a MAC type
Message-ID: <20170119235512.24962.55784.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add default setting for mac->ops.setup_link on x550em_a MAC types.
This fixes a link issue on KR parts.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index af579c2..04d6c74 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3795,7 +3795,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.get_media_type		= ixgbe_get_media_type_X550em,
 	.get_san_mac_addr	= NULL,
 	.get_wwn_prefix		= NULL,
-	.setup_link		= NULL, /* defined later */
+	.setup_link		= &ixgbe_setup_mac_link_X540,
 	.get_link_capabilities	= ixgbe_get_link_capabilities_X550em,
 	.get_bus_info		= ixgbe_get_bus_info_X550em,
 	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,

