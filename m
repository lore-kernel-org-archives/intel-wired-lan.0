From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:50:34 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 08/14] i40e: use changed_flags
 to check I40E_FLAG_DISABLE_FW_LLDP
Message-ID: <20171229135034.14504-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Currently in i40e_set_priv_flags we use new_flags to check for the
I40E_FLAG_DISABLE_FW_LLDP flag.  This is an issue for a few a reasons.
DISABLE_FW_LLDP is persistent across reboots/driver reloads.  This means
we need some way to detect if FW LLDP is enabled on init.  We do this by
trying to init_dcb and if it fails with EPERM we know LLDP is disabled
in FW.

This could be a problem on older FW versions or NPAR enabled PFs because
there are situations where the FW could disable LLDP, but they do _not_
support using this flag to change it.  If we do end up in this
situation, the flag will be set, then when the user tries to change any
priv flags, the driver thinks the user is trying to disable FW LLDP on a
FW that doesn't support it and essentially forbids any priv flag
changes.

The fix is simple, instead of checking if this flag is set, we should be
checking if the user is trying to _change_ the flag on unsupported FW
versions.

This patch also adds a comment explaining that the cmpxchg is the point
of no return.  Once we put the new flags into pf->flags we can't back
out.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7267a93..5b18e20 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4406,6 +4406,8 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	}
 
 flags_complete:
+	changed_flags = orig_flags ^ new_flags;
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
@@ -4415,13 +4417,17 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
 		return -EOPNOTSUPP;
 
-	/* Disable FW LLDP not supported if NPAR active or if FW
-	 * API version < 1.7
+	/* If the driver detected FW LLDP was disabled on init, this flag could
+	 * be set, however we do not support _changing_ the flag if NPAR is
+	 * enabled or FW API version < 1.7.  There are situations where older
+	 * FW versions/NPAR enabled PFs could disable LLDP, however we _must_
+	 * not allow the user to enable/disable LLDP with this flag on
+	 * unsupported FW verions.
 	 */
-	if (new_flags & I40E_FLAG_DISABLE_FW_LLDP) {
+	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
 		if (pf->hw.func_caps.npar_enable) {
 			dev_warn(&pf->pdev->dev,
-				 "Unable to stop FW LLDP if NPAR active\n");
+				 "Unable to change FW LLDP if NPAR active\n");
 			return -EOPNOTSUPP;
 		}
 
@@ -4429,7 +4435,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		    (pf->hw.aq.api_maj_ver == 1 &&
 		     pf->hw.aq.api_min_ver < 7)) {
 			dev_warn(&pf->pdev->dev,
-				 "FW ver does not support stopping FW LLDP\n");
+				 "FW ver does not support changing FW LLDP\n");
 			return -EOPNOTSUPP;
 		}
 	}
@@ -4439,6 +4445,10 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 * something else has modified the flags variable since we copied it
 	 * originally. We'll just punt with an error and log something in the
 	 * message buffer.
+	 *
+	 * This is the point of no return for this function.  We need to have
+	 * checked any discrepencies or misconfigurations and returned
+	 * EOPNOTSUPP before updating pf->flags here.
 	 */
 	if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
 		dev_warn(&pf->pdev->dev,
@@ -4446,8 +4456,6 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		return -EAGAIN;
 	}
 
-	changed_flags = orig_flags ^ new_flags;
-
 	/* Process any additional changes needed as a result of flag changes.
 	 * The changed_flags value reflects the list of bits that were
 	 * changed in the code above.
-- 
2.9.5

