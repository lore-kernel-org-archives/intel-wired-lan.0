From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 27 Oct 2021 06:32:50 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: remove unnecessary RTNL
 lock assert
Message-ID: <20211027043250.5241-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Follow changes in commit 7c3a0a018e67 ("net/{mlx5|nfp|bnxt}: Remove
unnecessary RTNL lock assert").

Remove the assert from the callback priv lookup function since it does
not require RTNL lock and is already protected by flow_indr_block_lock.

Having this assert in the ice_indr_block_priv_lookup leads to ugly
assert failed information in dmesg after:
- creating gretap tunnel
- adding tc qdisc on the tunnel device
- rmmod driver
- insmod driver

As this assert isn't needed, remove it.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: support for indirect notification"

 drivers/net/ethernet/intel/ice/ice_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 728c11103b37..d7ecbec93b11 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8153,9 +8153,6 @@ ice_indr_block_priv_lookup(struct ice_netdev_priv *np,
 {
 	struct ice_indr_block_priv *cb_priv;
 
-	/* All callback list access should be protected by RTNL. */
-	ASSERT_RTNL();
-
 	list_for_each_entry(cb_priv, &np->tc_indr_block_priv_list, list) {
 		if (!cb_priv->netdev)
 			return NULL;
-- 
2.31.1

