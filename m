From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 16:08:52 -0700
Subject: [Intel-wired-lan] [next PATCH S51-V2 7/8] i40e: fix trivial typo in
	naming of i40e_sync_filters_subtask
In-Reply-To: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477436933-13679-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A comment incorrectly referred to i40e_vsi_sync_filters_subtask which
does not actually exist. Reference the correct function instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I6bd805c605741ffb6fe34377259bb0d597edfafd
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f8eae1..c7b3a39 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1211,12 +1211,12 @@ bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi)
 	 *    i40e_add_filter.
 	 *
 	 * 2) the only place where filters are actually removed is in
-	 *    i40e_vsi_sync_filters_subtask.
+	 *    i40e_sync_filters_subtask.
 	 *
 	 * Thus, we can simply use a boolean value, has_vlan_filters which we
 	 * will set to true when we add a vlan filter in i40e_add_filter. Then
 	 * we have to perform the full search after deleting filters in
-	 * i40e_vsi_sync_filters_subtask, but we already have to search
+	 * i40e_sync_filters_subtask, but we already have to search
 	 * filters here and can perform the check at the same time. This
 	 * results in avoiding embedding a loop for vlan mode inside another
 	 * loop over all the filters, and should maintain correctness as noted
-- 
2.4.11

