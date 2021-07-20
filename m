From: kernel test robot <lkp@intel.com>
Date: Wed, 21 Jul 2021 00:38:40 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 138/260]
 include/net/switchdev.h:410:1: error: expected identifier or '(' before '{'
 token
Message-ID: <202107210033.1X19OEqX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   820d2640bb89ab196c46c299c066b2ad1ea65b84
commit: 8ca07176ab00a6d06a9b254dcbb2514b4d607e9c [138/260] net: switchdev: introduce a fanout helper for SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE
config: parisc-randconfig-r021-20210720 (attached as .config)
compiler: hppa-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=8ca07176ab00a6d06a9b254dcbb2514b4d607e9c
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 8ca07176ab00a6d06a9b254dcbb2514b4d607e9c
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/net/dsa.h:23,
                    from net/core/flow_dissector.c:8:
>> include/net/switchdev.h:410:1: error: expected identifier or '(' before '{' token
     410 | {
         | ^
   include/net/switchdev.h:399:1: warning: 'switchdev_handle_fdb_del_to_device' declared 'static' but never defined [-Wunused-function]
     399 | switchdev_handle_fdb_del_to_device(struct net_device *dev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +410 include/net/switchdev.h

   397	
   398	static inline int
   399	switchdev_handle_fdb_del_to_device(struct net_device *dev,
   400			const struct switchdev_notifier_fdb_info *fdb_info,
   401			bool (*check_cb)(const struct net_device *dev),
   402			bool (*foreign_dev_check_cb)(const struct net_device *dev,
   403						     const struct net_device *foreign_dev),
   404			int (*del_cb)(struct net_device *dev,
   405				      const struct net_device *orig_dev, const void *ctx,
   406				      const struct switchdev_notifier_fdb_info *fdb_info),
   407			int (*lag_del_cb)(struct net_device *dev,
   408					  const struct net_device *orig_dev, const void *ctx,
   409					  const struct switchdev_notifier_fdb_info *fdb_info));
 > 410	{
   411		return 0;
   412	}
   413	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25511 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210721/f8b6bb37/attachment-0001.bin>
