From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:23 -0700
Subject: [Intel-wired-lan] [next PATCH S34 03/12] i40e: Prevent falling to
	promiscuous if the VF is not trusted
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-4-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

With this change a non trusted VF can never fall to promiscuous
mode when there is no room for a mac/vlan filter.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-Id: I8a155aa25c0bcdc6093414920c9ade4ee0bd20e8
---
Testing Hints :
Try adding mac/vlan filters to multiple VFs and make sure they can
no longer go into promiscuous mode if the VFs are not trusted.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 39b3b56..a45748e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2098,6 +2098,12 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		}
 	}
 
+	/* if the VF is not trusted do not do promisc */
+	if ((vsi->type == I40E_VSI_SRIOV) && !pf->vf[vsi->vf_id].trusted) {
+		clear_bit(__I40E_FILTER_OVERFLOW_PROMISC, &vsi->state);
+		goto out;
+	}
+
 	/* check for changes in promiscuous modes */
 	if (changed_flags & IFF_ALLMULTI) {
 		bool cur_multipromisc;
-- 
2.4.3

