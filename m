From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:07 -0800
Subject: [Intel-wired-lan] [next PATCH S21 09/14] i40e: use priv flags to
	control packet split
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-10-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Ethtool priv flags implementation to enable or disable packet split, which
is a hardware feature that inspects headers and will put headers in a
separate DMA buffer from the payload data.  The driver was automatically
choosing to enable packet split in some cases and this gives the user the
ability to turn it off/on explicitly.

to query state:
ethtool --show-priv-flags ethx

to enable:
ethtool --set-priv-flags ethx packet-split on
to disable:
ethtool --set-priv-flags ethx packet-split off

Why would anyone want this?
	Because some environments benefit from header/data split in the receive
	buffer, and the driver defaults to one or the other depending on
	environment/kernel parameters.

Why didn't you implement a generic ethtool control for this feature?
	Because Intel hardware is the only hardware that supports header/data
	split.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I803121e1eecc9ccb2884031fd85dd1110b3af66d
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 27 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 768a19b..050fc0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -104,6 +104,7 @@
 #define I40E_PRIV_FLAGS_LINKPOLL_FLAG	BIT(1)
 #define I40E_PRIV_FLAGS_FD_ATR		BIT(2)
 #define I40E_PRIV_FLAGS_VEB_STATS	BIT(3)
+#define I40E_PRIV_FLAGS_PS		BIT(4)
 
 #define I40E_NVM_VERSION_LO_SHIFT  0
 #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index b52c509..d686041 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -231,6 +231,7 @@ static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"LinkPolling",
 	"flow-director-atr",
 	"veb-stats",
+	"packet-split",
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
@@ -2709,6 +2710,8 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 		I40E_PRIV_FLAGS_FD_ATR : 0;
 	ret_flags |= pf->flags & I40E_FLAG_VEB_STATS_ENABLED ?
 		I40E_PRIV_FLAGS_VEB_STATS : 0;
+	ret_flags |= pf->flags & I40E_FLAG_RX_PS_ENABLED ?
+		I40E_PRIV_FLAGS_PS : 0;
 
 	return ret_flags;
 }
@@ -2723,6 +2726,26 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
+	bool reset_required = false;
+
+	/* NOTE: MFP is not settable */
+
+	/* allow the user to control the method of receive
+	 * buffer dma, whether the packet is split at header
+	 * boundaries into two separate buffers.  In some cases
+	 * one routine or the other will perform better.
+	 */
+	if ((flags & I40E_PRIV_FLAGS_PS) &&
+	    !(pf->flags & I40E_FLAG_RX_PS_ENABLED)) {
+		pf->flags |= I40E_FLAG_RX_PS_ENABLED;
+		pf->flags &= ~I40E_FLAG_RX_1BUF_ENABLED;
+		reset_required = true;
+	} else if (!(flags & I40E_PRIV_FLAGS_PS) &&
+		   (pf->flags & I40E_FLAG_RX_PS_ENABLED)) {
+		pf->flags &= ~I40E_FLAG_RX_PS_ENABLED;
+		pf->flags |= I40E_FLAG_RX_1BUF_ENABLED;
+		reset_required = true;
+	}
 
 	if (flags & I40E_PRIV_FLAGS_LINKPOLL_FLAG)
 		pf->flags |= I40E_FLAG_LINK_POLLING_ENABLED;
@@ -2745,6 +2768,10 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	else
 		pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
 
+	/* if needed, issue reset to cause things to take effect */
+	if (reset_required)
+		i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED));
+
 	return 0;
 }
 
-- 
2.1.0

