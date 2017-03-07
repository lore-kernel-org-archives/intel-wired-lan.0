From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Mar 2017 15:17:52 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: make use of
	hlist_for_each_entry_continue
Message-ID: <20170307231752.21671-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace a complex if->continue->else->break construction in
i40e_next_filter. We can simply use hlist_for_each_entry_continue
instead. This drops a lot of confusing code. The resulting code is much
easier to understand the intention, and follows the more normal pattern
for using hlist loops. We could have also used a break with a "return
next" at the end of the function, instead of return NULL, but the
current implementation is explicitly clear that when you reach the end
of the loop you get a NULL value. The alternative construction is less
clear since the reader would have to know that next is NULL at the end
of the loop.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: Ife74ca451dd79d7f0d93c672bd42092d324d4a03
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 836ce939e65b..1e0acf764c79 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1817,19 +1817,12 @@ static void i40e_undo_add_filter_entries(struct i40e_vsi *vsi,
 static
 struct i40e_new_mac_filter *i40e_next_filter(struct i40e_new_mac_filter *next)
 {
-	while (next) {
-		next = hlist_entry(next->hlist.next,
-				   typeof(struct i40e_new_mac_filter),
-				   hlist);
-
-		/* keep going if we found a broadcast filter */
-		if (next && is_broadcast_ether_addr(next->f->macaddr))
-			continue;
-
-		break;
+	hlist_for_each_entry_continue(next, hlist) {
+		if (!is_broadcast_ether_addr(next->f->macaddr))
+			return next;
 	}
 
-	return next;
+	return NULL;
 }
 
 /**
-- 
2.12.0.rc1.272.g5157a0d593b8

