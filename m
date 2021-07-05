From: Taehee Yoo <ap420073@gmail.com>
Date: Mon,  5 Jul 2021 15:38:14 +0000
Subject: [Intel-wired-lan] [PATCH net v2 9/9] bonding: fix incorrect return
 value of bond_ipsec_offload_ok()
In-Reply-To: <20210705153814.11453-1-ap420073@gmail.com>
References: <20210705153814.11453-1-ap420073@gmail.com>
Message-ID: <20210705153814.11453-10-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

bond_ipsec_offload_ok() is called to check whether the interface supports
ipsec offload or not.
bonding interface support ipsec offload only in active-backup mode.
So, if a bond interface is not in active-backup mode, it should return
false but it returns true.

Fixes: a3b658cfb664 ("bonding: allow xfrm offload setup post-module-load")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
v1 -> v2:
 - newly added

 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a9cb06959320..3bc6266ede0e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,7 +581,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	real_dev = curr_active->dev;
 
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = true;
+		err = false;
 		goto out;
 	}
 
-- 
2.17.1

