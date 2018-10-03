From: Lance Roy <ldr709@gmail.com>
Date: Tue,  2 Oct 2018 22:38:50 -0700
Subject: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked() with
 lockdep
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Message-ID: <20181003053902.6910-5-ldr709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan at lists.osuosl.org
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ac685ad4d877..8ce3471723d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1489,8 +1489,7 @@ int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr)
 	bool found = false;
 	int bkt;
 
-	WARN(!spin_is_locked(&vsi->mac_filter_hash_lock),
-	     "Missing mac_filter_hash_lock\n");
+	lockdep_assert_held(&vsi->mac_filter_hash_lock);
 	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
 		if (ether_addr_equal(macaddr, f->macaddr)) {
 			__i40e_del_filter(vsi, f);
-- 
2.19.0

