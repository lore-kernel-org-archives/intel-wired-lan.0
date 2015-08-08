From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:19:04 -0700
Subject: [Intel-wired-lan] [PATCH V5 16/19] ixgbe: Correct setting of
 RDRXCTL register for X550* devices
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231904.94784.26531.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setting the X550* RDRXCTL register should fall through into X540
and 82599, not 82598.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index af5e49a4e95c..eecd70b170f3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3789,8 +3789,6 @@ static void ixgbe_setup_rdrxctl(struct ixgbe_adapter *adapter)
 	u32 rdrxctl = IXGBE_READ_REG(hw, IXGBE_RDRXCTL);
 
 	switch (hw->mac.type) {
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_82598EB:
 		/*
 		 * For VMDq support of different descriptor types or
@@ -3804,6 +3802,8 @@ static void ixgbe_setup_rdrxctl(struct ixgbe_adapter *adapter)
 		 */
 		rdrxctl |= IXGBE_RDRXCTL_MVMEN;
 		break;
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X540:
 		/* Disable RSC for ACK packets */

