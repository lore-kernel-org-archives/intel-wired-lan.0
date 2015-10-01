From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:37 -0400
Subject: [Intel-wired-lan] [next PATCH S18 4/8] i40evf: use correct struct
	for list manipulation
In-Reply-To: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443724661-92168-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Not sure how this compiles at all. Use the correct struct for
manipulating the VLAN filter list. Without this, the VLAN filter
list doesn't get processed correctly, and VLAN filters will not
be re-enabled after any kind of reset.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Iceff2dc089f303058fb71ecb08419eed471e0e90
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index e5e132a..ec19b91 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1609,6 +1609,7 @@ static void i40evf_reset_task(struct work_struct *work)
 						      reset_task);
 	struct net_device *netdev = adapter->netdev;
 	struct i40e_hw *hw = &adapter->hw;
+	struct i40evf_vlan_filter *vlf;
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i = 0, err;
@@ -1732,8 +1733,8 @@ continue_reset:
 		f->add = true;
 	}
 	/* re-add all VLAN filters */
-	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-		f->add = true;
+	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
+		vlf->add = true;
 	}
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
-- 
1.9.3

