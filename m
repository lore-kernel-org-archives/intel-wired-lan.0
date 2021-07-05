From: Taehee Yoo <ap420073@gmail.com>
Date: Mon,  5 Jul 2021 15:38:11 +0000
Subject: [Intel-wired-lan] [PATCH net v2 6/9] bonding: disallow setting
 nested bonding + ipsec offload
In-Reply-To: <20210705153814.11453-1-ap420073@gmail.com>
References: <20210705153814.11453-1-ap420073@gmail.com>
Message-ID: <20210705153814.11453-7-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

bonding interface can be nested and it supports ipsec offload.
So, it allows setting the nested bonding + ipsec scenario.
But code does not support this scenario.
So, it should be disallowed.

interface graph:
bond2
   |
bond1
   |
eth0

The nested bonding + ipsec offload may not a real usecase.
So, disallowing this scenario is fine.

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
v1 -> v2:
 - no change

 drivers/net/bonding/bond_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7659e1fab19e..f268e67cb2f0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -419,8 +419,9 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs)
 	xs->xso.real_dev = slave->dev;
 	bond->xs = xs;
 
-	if (!(slave->dev->xfrmdev_ops
-	      && slave->dev->xfrmdev_ops->xdo_dev_state_add)) {
+	if (!slave->dev->xfrmdev_ops ||
+	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
+	    netif_is_bond_master(slave->dev)) {
 		slave_warn(bond_dev, slave->dev, "Slave does not support ipsec offload\n");
 		rcu_read_unlock();
 		return -EINVAL;
@@ -453,8 +454,9 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	xs->xso.real_dev = slave->dev;
 
-	if (!(slave->dev->xfrmdev_ops
-	      && slave->dev->xfrmdev_ops->xdo_dev_state_delete)) {
+	if (!slave->dev->xfrmdev_ops ||
+	    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
+	    netif_is_bond_master(slave->dev)) {
 		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_delete\n", __func__);
 		goto out;
 	}
@@ -479,8 +481,9 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		return true;
 
-	if (!(slave_dev->xfrmdev_ops
-	      && slave_dev->xfrmdev_ops->xdo_dev_offload_ok)) {
+	if (!slave_dev->xfrmdev_ops ||
+	    !slave_dev->xfrmdev_ops->xdo_dev_offload_ok ||
+	    netif_is_bond_master(slave_dev)) {
 		slave_warn(bond_dev, slave_dev, "%s: no slave xdo_dev_offload_ok\n", __func__);
 		return false;
 	}
-- 
2.17.1

