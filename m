From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 12:40:02 -0700
Subject: [Intel-wired-lan] [next PATCH S45 05/10] i40e: fix deleting mac
	filters
In-Reply-To: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473190807-26377-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

There exists a bug in which deleting a mac filter does not actually
occur.  The driver reports that the filter has been deleted with no
error.  The problem occurs because the wrong cmd_flag is passed to the
firmware when deleting the filter.  The firmware reports an error back
to the driver but it is expressly ignored.

This fixes the bug by using the correct flag when deleting a filter.
Without this patch, deleted filters remain in firmware and function as
if they had not been deleted.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: I5f22b874f3b83f457702f18f0d5602ca21ac40c3
---
Testing-hints:
        I used 'tcpdump -npi <iface>' to watch traffic.

        1.  Pass traffic with mac header 00:aa:00:aa:02:01 - no traffic
        2.  Add mac filter - ip maddr add 00:aa:00:aa:02:01 dev enp5s0f0
        3.  Pass traffic with mac header 00:aa:00:aa:02:01 - traffic
        4.  Delete mac filter - ip maddr del 00:aa:00:aa:02:01 dev enp5s0f0
        5.  Pass traffic with mac header 00:aa:00:aa:02:01
                Expected - no traffic
                Actual - traffic

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e83b317..4c3c6ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1315,7 +1315,7 @@ static void i40e_rm_default_mac_filter(struct i40e_vsi *vsi, u8 *macaddr)
 	element.vlan_tag = 0;
 	/* ...and some firmware does it this way. */
 	element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH |
-			I40E_AQC_MACVLAN_ADD_IGNORE_VLAN;
+			I40E_AQC_MACVLAN_DEL_IGNORE_VLAN;
 	i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
 }
 
@@ -1908,7 +1908,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			ether_addr_copy(del_list[num_del].mac_addr, f->macaddr);
 			if (f->vlan == I40E_VLAN_ANY) {
 				del_list[num_del].vlan_tag = 0;
-				cmd_flags |= I40E_AQC_MACVLAN_ADD_IGNORE_VLAN;
+				cmd_flags |= I40E_AQC_MACVLAN_DEL_IGNORE_VLAN;
 			} else {
 				del_list[num_del].vlan_tag =
 					cpu_to_le16((u16)(f->vlan));
-- 
2.4.11

