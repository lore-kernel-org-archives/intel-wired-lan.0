From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 7 Feb 2020 07:11:23 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/2] igb: Use device_lock() insead
 of rtnl_lock()
In-Reply-To: <20200205081616.18378-1-kai.heng.feng@canonical.com>
Message-ID: <20200207041123.GO24804@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Kai-Heng,

url:    https://github.com/0day-ci/linux/commits/Kai-Heng-Feng/igb-Use-device_lock-insead-of-rtnl_lock/20200205-174208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/intel/igb/igb_main.c:4036 igb_close() warn: inconsistent returns 'dev->mutex'.

# https://github.com/0day-ci/linux/commit/905877ae7d44efc1d9c5c1ae9f4489f56bcb13a6
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 905877ae7d44efc1d9c5c1ae9f4489f56bcb13a6
vim +4036 drivers/net/ethernet/intel/igb/igb_main.c

9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok       2008-01-24  4026  
46eafa59e18d03 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann 2016-02-03  4027  int igb_close(struct net_device *netdev)
749ab2cd127046 drivers/net/ethernet/intel/igb/igb_main.c Yan, Zheng     2012-01-04  4028  {
905877ae7d44ef drivers/net/ethernet/intel/igb/igb_main.c Kai-Heng Feng  2020-02-05  4029  	struct igb_adapter *adapter = netdev_priv(netdev);
905877ae7d44ef drivers/net/ethernet/intel/igb/igb_main.c Kai-Heng Feng  2020-02-05  4030  	struct device *dev = &adapter->pdev->dev;
905877ae7d44ef drivers/net/ethernet/intel/igb/igb_main.c Kai-Heng Feng  2020-02-05  4031  
905877ae7d44ef drivers/net/ethernet/intel/igb/igb_main.c Kai-Heng Feng  2020-02-05  4032  	device_lock(dev);
888f22931478a0 drivers/net/ethernet/intel/igb/igb_main.c Lyude Paul     2017-12-12  4033  	if (netif_device_present(netdev) || netdev->dismantle)
749ab2cd127046 drivers/net/ethernet/intel/igb/igb_main.c Yan, Zheng     2012-01-04  4034  		return __igb_close(netdev, false);
                                                                                                        ^^^^^^
Lock held for this return.

905877ae7d44ef drivers/net/ethernet/intel/igb/igb_main.c Kai-Heng Feng  2020-02-05  4035  	device_unlock(dev);
9474933caf21a4 drivers/net/ethernet/intel/igb/igb_main.c Todd Fujinaka  2016-11-15 @4036  	return 0;
749ab2cd127046 drivers/net/ethernet/intel/igb/igb_main.c Yan, Zheng     2012-01-04  4037  }
749ab2cd127046 drivers/net/ethernet/intel/igb/igb_main.c Yan, Zheng     2012-01-04  4038  

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
