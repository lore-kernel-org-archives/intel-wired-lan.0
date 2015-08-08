From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:17:51 -0700
Subject: [Intel-wired-lan] [PATCH V5 02/19] ixgbe: Add X550EM support for
 SFP insertion interrupt
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231751.94784.84787.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for the SFP insertion interrupt on X550EM devices with
SFPs.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6c52300fecfe..d289449a9b83 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2631,6 +2631,8 @@ static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+		if (adapter->hw.device_id == IXGBE_DEV_ID_X550EM_X_SFP)
+			mask |= IXGBE_EIMS_GPI_SDP0(&adapter->hw);
 		if (adapter->hw.phy.type == ixgbe_phy_x550em_ext_t)
 			mask |= IXGBE_EICR_GPI_SDP0_X540;
 		mask |= IXGBE_EIMS_ECC;

