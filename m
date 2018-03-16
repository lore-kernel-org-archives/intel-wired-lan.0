From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:36 -0700
Subject: [Intel-wired-lan] [next PATCH S89 7/8] i40e: stop using cmpxchg
 flow in i40e_set_priv_flags()
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Now that the only places which modify flags are either (a) during
initialization prior to creating a netdevice, or (b) while holding the
rtnl lock, we no longer need the cmpxchg64 call in i40e_set_priv_flags.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 031bc7c..9a97f3f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4436,21 +4436,12 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		}
 	}
 
-	/* Compare and exchange the new flags into place. If we failed, that
-	 * is if cmpxchg returns anything but the old value, this means that
-	 * something else has modified the flags variable since we copied it
-	 * originally. We'll just punt with an error and log something in the
-	 * message buffer.
-	 *
-	 * This is the point of no return for this function.  We need to have
-	 * checked any discrepancies or misconfigurations and returned
-	 * EOPNOTSUPP before updating pf->flags here.
+	/* Now that we've checked to ensure that the new flags are valid, load
+	 * them into place. Since we only modify flags either (a) during
+	 * initialization or (b) while holding the RTNL lock, we don't need
+	 * anything fancy here.
 	 */
-	if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
-		dev_warn(&pf->pdev->dev,
-			 "Unable to update pf->flags as it was modified by another thread...\n");
-		return -EAGAIN;
-	}
+	pf->flags = new_flags;
 
 	/* Process any additional changes needed as a result of flag changes.
 	 * The changed_flags value reflects the list of bits that were
-- 
2.9.5

