From: Jay Vosburgh <jay.vosburgh@canonical.com>
Date: Fri, 02 Jul 2021 14:26:24 -0700
Subject: [Intel-wired-lan] [PATCH net 6/8] bonding: disallow setting
 nested bonding + ipsec offload
In-Reply-To: <20210702142648.7677-7-ap420073@gmail.com>
References: <20210702142648.7677-1-ap420073@gmail.com>
 <20210702142648.7677-7-ap420073@gmail.com>
Message-ID: <14516.1625261184@famine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Taehee Yoo <ap420073@gmail.com> wrote:

[...]
>@@ -479,8 +481,9 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
> 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> 		return true;

	Not a question about this patch, but isn't the "return true"
above incorrect (i.e., should return false)?  I understand that the
ipsec offload is only available for active-backup mode, but the test
above will return true for all modes other than active-backup.

	-J

>-	if (!(slave_dev->xfrmdev_ops
>-	      && slave_dev->xfrmdev_ops->xdo_dev_offload_ok)) {
>+	if (!slave_dev->xfrmdev_ops ||
>+	    !slave_dev->xfrmdev_ops->xdo_dev_offload_ok ||
>+	    netif_is_bond_master(slave_dev)) {
> 		slave_warn(bond_dev, slave_dev, "%s: no slave xdo_dev_offload_ok\n", __func__);
> 		return false;
> 	}
>-- 
>2.17.1
>

---
	-Jay Vosburgh, jay.vosburgh at canonical.com
