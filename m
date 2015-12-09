From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:23 -0800
Subject: [Intel-wired-lan] [next PATCH S23 03/13] i40e: Add
	mac_filter_element at the end of the list instead of HEAD
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-4-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Add MAC filter element to the end of the list in the given order,
just to be tidy, and just in case there are ever any ordering issues in
the future.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: Idc15276147593ea9393ac72c861f9c7905a791b4
---
Testing Hints: There is no straight targeted test for this issue.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4fd29e7..44bbfd8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1365,7 +1365,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 		f->changed = true;
 
 		INIT_LIST_HEAD(&f->list);
-		list_add(&f->list, &vsi->mac_filter_list);
+		list_add_tail(&f->list, &vsi->mac_filter_list);
 	}
 
 	/* increment counter and add a new flag if needed */
-- 
2.1.0

