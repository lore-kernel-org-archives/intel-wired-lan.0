From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:05 -0800
Subject: [Intel-wired-lan] [next PATCH S26 05/12] i40e: allocate memory safer
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-6-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The sync_vsi_filter function was allocating memory in such
a way that it could sleep (GFP_KERNEL) which was causing a problem
when called by the team driver under rcu_read_lock(), which cannot
be held while sleeping.  Found with lockdep.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I4e59053cb5eedcf3d0ca151715be3dc42a94bdd5
---
Testing-Hints:
Run lockdep enabled kernel and try these steps:
  teamd -t team0 -rd -c '{"runner":{"name":"activebackup"}}'
  teamdctl team0 port add ens3f0
  teamdctl team0 port add ens3f0
  teamdctl team0 port add ens3f1
  ip link set team0 up
  ip link add link team0 name team0.3 type vlan id 3
  ip l set team0.3 up
  ip link del team0.3

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cbbe2f9..052314c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1937,7 +1937,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
 		del_list_size = filter_list_len *
 			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
-		del_list = kzalloc(del_list_size, GFP_KERNEL);
+		del_list = kzalloc(del_list_size, GFP_ATOMIC);
 		if (!del_list) {
 			i40e_cleanup_add_list(&tmp_add_list);
 
@@ -2015,7 +2015,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			       sizeof(struct i40e_aqc_add_macvlan_element_data),
 		add_list_size = filter_list_len *
 			       sizeof(struct i40e_aqc_add_macvlan_element_data);
-		add_list = kzalloc(add_list_size, GFP_KERNEL);
+		add_list = kzalloc(add_list_size, GFP_ATOMIC);
 		if (!add_list) {
 			/* Purge element from temporary lists */
 			i40e_cleanup_add_list(&tmp_add_list);
-- 
2.1.0

