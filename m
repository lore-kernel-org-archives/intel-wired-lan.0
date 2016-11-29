From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:03 -0800
Subject: [Intel-wired-lan] [next PATCH S55 06/14] i40e: add interrupt rate
	limit verbosity
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Due to the resolution of the register controlling interrupt rate
limiting, setting certain values for the interrupt rate limit make it
appear as though the limiting is not completely accurate.  The problem
is that the interrupt rate limit is getting rounded down to the nearest
multiple of 4.  This patch fixes the problem by adding some feedback to
the user as to the actual interrupt rate limit being used when it
differs from the requested limit.  Without this patch setting interrupt
rate limits may appear to behave inaccurately.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: I3093cf3f2d437d35a4c4f4bb5af5ce1b85ab21b7
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 977ae6f..f9f71fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2116,6 +2116,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
+	u16 intrl_reg;
 	int i;
 
 	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
@@ -2127,8 +2128,9 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (ec->rx_coalesce_usecs_high >= INTRL_REG_TO_USEC(I40E_MAX_INTRL)) {
-		netif_info(pf, drv, netdev, "Invalid value, rx-usecs-high range is 0-235\n");
+	if (ec->rx_coalesce_usecs_high > INTRL_REG_TO_USEC(I40E_MAX_INTRL)) {
+		netif_info(pf, drv, netdev, "Invalid value, rx-usecs-high range is 0-%lu\n",
+			   INTRL_REG_TO_USEC(I40E_MAX_INTRL));
 		return -EINVAL;
 	}
 
@@ -2141,7 +2143,12 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 			return -EINVAL;
 	}
 
-	vsi->int_rate_limit = ec->rx_coalesce_usecs_high;
+	intrl_reg = i40e_intrl_usec_to_reg(ec->rx_coalesce_usecs_high);
+	vsi->int_rate_limit = INTRL_REG_TO_USEC(intrl_reg);
+	if (vsi->int_rate_limit != ec->rx_coalesce_usecs_high) {
+		netif_info(pf, drv, netdev, "Interrupt rate limit rounded down to %d\n",
+			   vsi->int_rate_limit);
+	}
 
 	if (ec->tx_coalesce_usecs == 0) {
 		if (ec->use_adaptive_tx_coalesce)
-- 
2.4.11

