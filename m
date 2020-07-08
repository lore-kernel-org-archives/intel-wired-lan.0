From: Jarod Wilson <jarod@redhat.com>
Date: Wed,  8 Jul 2020 18:58:49 -0400
Subject: [Intel-wired-lan] [PATCH net-next] bonding: don't need RTNL for
 ipsec helpers
Message-ID: <20200708225849.25198-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The bond_ipsec_* helpers don't need RTNL, and can potentially get called
without it being held, so switch from rtnl_dereference() to
rcu_dereference() to access bond struct data.

Lightly tested with xfrm bonding, no problems found, should address the
syzkaller bug referenced below.

Reported-by: syzbot+582c98032903dcc04816 at syzkaller.appspotmail.com
CC: Huy Nguyen <huyn@mellanox.com>
CC: Saeed Mahameed <saeedm@mellanox.com>
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev at vger.kernel.org
CC: intel-wired-lan at lists.osuosl.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f886d97c4359..e2d491c4378c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -390,7 +390,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 
 	bond = netdev_priv(bond_dev);
-	slave = rtnl_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->curr_active_slave);
 	xs->xso.real_dev = slave->dev;
 	bond->xs = xs;
 
@@ -417,7 +417,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 		return;
 
 	bond = netdev_priv(bond_dev);
-	slave = rtnl_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->curr_active_slave);
 
 	if (!slave)
 		return;
@@ -442,7 +442,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *curr_active = rtnl_dereference(bond->curr_active_slave);
+	struct slave *curr_active = rcu_dereference(bond->curr_active_slave);
 	struct net_device *slave_dev = curr_active->dev;
 
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
-- 
2.20.1

