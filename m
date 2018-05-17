From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:36 -0700
Subject: [Intel-wired-lan] [next PATCH S92 5/9] i40e: use WARN_ONCE to
 replace the commented BUG_ON size check
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We don't really want to use BUG_ON here since that would completely
crash the kernel, thus the reason we commented it out. We *can't* use
BUILD_BUG_ON because at least now (a) the sizes aren't constant (we are
fixing this) and (b) not all compilers are smart enough to understand
that "p - data" is a constant.

Instead, just use a WARN_ONCE so that the first time we end up with an
incorrect size we will dump a stack trace and a message, hopefully
highlighting the issues early in testing.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index cc09dd7..9bddae4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1672,8 +1672,8 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	char *p = (char *)data;
 	unsigned int i;
+	u8 *p = data;
 
 	for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
 		snprintf(p, ETH_GSTRING_LEN, "%s",
@@ -1744,7 +1744,9 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 			 "port.rx_priority_%u_xon_2_xoff", i);
 		p += ETH_GSTRING_LEN;
 	}
-	/* BUG_ON(p - data != I40E_STATS_LEN * ETH_GSTRING_LEN); */
+
+	WARN_ONCE(p - data != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
+		  "stat strings count mismatch!");
 }
 
 static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
-- 
2.9.5

