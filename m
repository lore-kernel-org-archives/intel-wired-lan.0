From: Sudarsana Kalluru <Sudarsana.Kalluru@qlogic.com>
Date: Fri, 10 Jun 2016 09:05:31 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 119/181]
 drivers/net/ethernet/qlogic/qede/qede_dcbnl.c:304:50-51: getdcbx: first
 occurrence line 311, second occurrence line 327 (fwd)
In-Reply-To: <alpine.DEB.2.10.1606100925360.4715@hadrien>
References: <alpine.DEB.2.10.1606100925360.4715@hadrien>
Message-ID: <BY2PR1101MB114284C695E35C0054E3035090500@BY2PR1101MB1142.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Julia,

    Thanks for your mail. Will remove it.

Thanks,
Sudarsana

-----Original Message-----
From: Julia Lawall [mailto:julia.lawall at lip6.fr] 
Sent: 10 June 2016 12:57
To: Sudarsana Kalluru <Sudarsana.Kalluru@qlogic.com>; Yuval Mintz <Yuval.Mintz@qlogic.com>; intel-wired-lan at lists.osuosl.org; kbuild-all at 01.org
Subject: [jkirsher-next-queue:dev-queue 119/181] drivers/net/ethernet/qlogic/qede/qede_dcbnl.c:304:50-51: getdcbx: first occurrence line 311, second occurrence line 327 (fwd)

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6011c26042a941a9527d3289300eeb22ad73f9c9
commit: 489e45ae42f000a5e045ac203ad5d6f08824cd56 [119/181] qede: Add dcbnl support.
:::::: branch date: 51 minutes ago
:::::: commit date: 7 hours ago

>> drivers/net/ethernet/qlogic/qede/qede_dcbnl.c:304:50-51: getdcbx: 
>> first occurrence line 311, second occurrence line 327


It looks like the two lines are identical, and one should just be removed.

julia

git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout 489e45ae42f000a5e045ac203ad5d6f08824cd56
vim +304 drivers/net/ethernet/qlogic/qede/qede_dcbnl.c

489e45ae Sudarsana Reddy Kalluru 2016-06-08  298  {
489e45ae Sudarsana Reddy Kalluru 2016-06-08  299  	struct qede_dev *edev = netdev_priv(netdev);
489e45ae Sudarsana Reddy Kalluru 2016-06-08  300
489e45ae Sudarsana Reddy Kalluru 2016-06-08  301  	return edev->ops->dcb->ieee_peer_getets(edev->cdev, ets);
489e45ae Sudarsana Reddy Kalluru 2016-06-08  302  } 489e45ae Sudarsana Reddy Kalluru 2016-06-08  303 489e45ae Sudarsana Reddy Kalluru 2016-06-08 @304  static const struct dcbnl_rtnl_ops qede_dcbnl_ops = {
489e45ae Sudarsana Reddy Kalluru 2016-06-08  305  	.ieee_getpfc = qede_dcbnl_ieee_getpfc,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  306  	.ieee_setpfc = qede_dcbnl_ieee_setpfc,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  307  	.ieee_getets = qede_dcbnl_ieee_getets,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  308  	.ieee_setets = qede_dcbnl_ieee_setets,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  309  	.ieee_getapp = qede_dcbnl_ieee_getapp,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  310  	.ieee_setapp = qede_dcbnl_ieee_setapp,
489e45ae Sudarsana Reddy Kalluru 2016-06-08 @311  	.getdcbx = qede_dcbnl_getdcbx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  312  	.ieee_peer_getpfc = qede_dcbnl_ieee_peer_getpfc,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  313  	.ieee_peer_getets = qede_dcbnl_ieee_peer_getets,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  314  	.getstate = qede_dcbnl_getstate,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  315  	.setstate = qede_dcbnl_setstate,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  316  	.getpermhwaddr = qede_dcbnl_getpermhwaddr,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  317  	.getpgtccfgtx = qede_dcbnl_getpgtccfgtx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  318  	.getpgbwgcfgtx = qede_dcbnl_getpgbwgcfgtx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  319  	.getpgtccfgrx = qede_dcbnl_getpgtccfgrx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  320  	.getpgbwgcfgrx = qede_dcbnl_getpgbwgcfgrx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  321  	.getpfccfg = qede_dcbnl_getpfccfg,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  322  	.setpfccfg = qede_dcbnl_setpfccfg,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  323  	.getcap = qede_dcbnl_getcap,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  324  	.getnumtcs = qede_dcbnl_getnumtcs,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  325  	.getpfcstate = qede_dcbnl_getpfcstate,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  326  	.getapp = qede_dcbnl_getapp,
489e45ae Sudarsana Reddy Kalluru 2016-06-08 @327  	.getdcbx = qede_dcbnl_getdcbx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  328  	.setpgtccfgtx = qede_dcbnl_setpgtccfgtx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  329  	.setpgtccfgrx = qede_dcbnl_setpgtccfgrx,
489e45ae Sudarsana Reddy Kalluru 2016-06-08  330  	.setpgbwgcfgtx = qede_dcbnl_setpgbwgcfgtx,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
