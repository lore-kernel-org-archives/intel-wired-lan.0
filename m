From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 12 Oct 2018 10:17:09 +0300
Subject: [Intel-wired-lan] [PATCH] ice: remove an unneeded NULL check
Message-ID: <20181012071709.GA10212@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We added a NULL check in commit 072f0c3db9da ("ice: Fix potential null
pointer issues") but it causes static checker warnings.

    drivers/net/ethernet/intel/ice/ice_switch.c:2145 ice_add_to_vsi_fltr_list()
    warn: address of 'fm_entry->fltr_info' is non-NULL

We can just remove it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 33403f39f1b3..a9ef19da6e61 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2142,7 +2142,7 @@ ice_add_to_vsi_fltr_list(struct ice_hw *hw, u16 vsi_handle,
 		struct ice_fltr_info *fi;
 
 		fi = &fm_entry->fltr_info;
-		if (!fi || !ice_vsi_uses_fltr(fm_entry, vsi_handle))
+		if (!ice_vsi_uses_fltr(fm_entry, vsi_handle))
 			continue;
 
 		status = ice_add_entry_to_vsi_fltr_list(hw, vsi_handle,
