From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 3 Jul 2021 15:37:48 +0900
Subject: [Intel-wired-lan] [PATCH net 6/8] bonding: disallow setting
 nested bonding + ipsec offload
In-Reply-To: <14149.1625260463@famine>
References: <20210702142648.7677-1-ap420073@gmail.com>
 <20210702142648.7677-7-ap420073@gmail.com> <14149.1625260463@famine>
Message-ID: <27082299-0436-2f95-11b9-9ba7077f165e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jay,
Thank you for your review!

On 7/3/21 6:14 AM, Jay Vosburgh wrote:
 > Taehee Yoo <ap420073@gmail.com> wrote:
 >
 >> bonding interface can be nested and it supports ipsec offload.
 >> So, it allows setting the nested bonding + ipsec scenario.
 >> But code does not support this scenario.
 >> So, it should be disallowed.
 >>
 >> interface graph:
 >> bond2
 >> |
 >> bond1
 >> |
 >> eth0
 >>
 >> The nested bonding + ipsec offload may not a real usecase.
 >> So, disallowing this is fine.
 >
 > 	Is a stack like "bond1 -> VLAN.XX -> bond2 -> eth0" also a
 > problem?  I don't believe the change below will detect this
 > configuration.
 >

Except bonding, all kind of virtual interfaces(vlan, team, etc) doesn't 
support ipsec offload.
It means these interfaces' xfrmdev_ops pointer is null.
So, configuration always will be failed at the following line.
         if (!slave->dev->xfrmdev_ops || 

             !slave->dev->xfrmdev_ops->xdo_dev_state_add || 

Only checking the real interface's type is enough.
So, bond1 can't set up ipsec offload but bond2 can set up ipsec offload.


Thanks a lot!
Taehee

 > 	-J
 >
 >> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload 
to slaves")
 >> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
 >> ---
 >> drivers/net/bonding/bond_main.c | 15 +++++++++------
 >> 1 file changed, 9 insertions(+), 6 deletions(-)
 >>
 >> diff --git a/drivers/net/bonding/bond_main.c 
b/drivers/net/bonding/bond_main.c
 >> index 7659e1fab19e..f268e67cb2f0 100644
 >> --- a/drivers/net/bonding/bond_main.c
 >> +++ b/drivers/net/bonding/bond_main.c
 >> @@ -419,8 +419,9 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs)
 >> 	xs->xso.real_dev = slave->dev;
 >> 	bond->xs = xs;
 >>
 >> -	if (!(slave->dev->xfrmdev_ops
 >> -	      && slave->dev->xfrmdev_ops->xdo_dev_state_add)) {
 >> +	if (!slave->dev->xfrmdev_ops ||
 >> +	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
 >> +	    netif_is_bond_master(slave->dev)) {
 >> 		slave_warn(bond_dev, slave->dev, "Slave does not support ipsec 
offload\n");
 >> 		rcu_read_unlock();
 >> 		return -EINVAL;
 >> @@ -453,8 +454,9 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 >>
 >> 	xs->xso.real_dev = slave->dev;
 >>
 >> -	if (!(slave->dev->xfrmdev_ops
 >> -	      && slave->dev->xfrmdev_ops->xdo_dev_state_delete)) {
 >> +	if (!slave->dev->xfrmdev_ops ||
 >> +	    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
 >> +	    netif_is_bond_master(slave->dev)) {
 >> 		slave_warn(bond_dev, slave->dev, "%s: no slave 
xdo_dev_state_delete\n", __func__);
 >> 		goto out;
 >> 	}
 >> @@ -479,8 +481,9 @@ static bool bond_ipsec_offload_ok(struct sk_buff 
*skb, struct xfrm_state *xs)
 >> 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 >> 		return true;
 >>
 >> -	if (!(slave_dev->xfrmdev_ops
 >> -	      && slave_dev->xfrmdev_ops->xdo_dev_offload_ok)) {
 >> +	if (!slave_dev->xfrmdev_ops ||
 >> +	    !slave_dev->xfrmdev_ops->xdo_dev_offload_ok ||
 >> +	    netif_is_bond_master(slave_dev)) {
 >> 		slave_warn(bond_dev, slave_dev, "%s: no slave 
xdo_dev_offload_ok\n", __func__);
 >> 		return false;
 >> 	}
 >> --
 >> 2.17.1
 >>
 >
 > ---
 > 	-Jay Vosburgh, jay.vosburgh at canonical.com
 >
