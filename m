From: kernel test robot <lkp@intel.com>
Date: Wed, 9 Dec 2020 16:58:19 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] fix possible array overflow on
 receiving too many fragments for a packet
In-Reply-To: <20201208040638.40627-1-ruc_zhangxiaohui@163.com>
References: <20201208040638.40627-1-ruc_zhangxiaohui@163.com>
Message-ID: <202012091653.tY6HS6tK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Xiaohui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on linus/master sparc-next/master v5.10-rc7 next-20201208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xiaohui-Zhang/fix-possible-array-overflow-on-receiving-too-many-fragments-for-a-packet/20201209-010457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: riscv-allyesconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4bc4508ab14b72993c4e9a927f8e82a1dfdcf39c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xiaohui-Zhang/fix-possible-array-overflow-on-receiving-too-many-fragments-for-a-packet/20201209-010457
        git checkout 4bc4508ab14b72993c4e9a927f8e82a1dfdcf39c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ip.h:16,
                    from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:4:
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c: In function 'ionic_rx_frags':
>> include/linux/skbuff.h:1431:53: warning: 'skb' is used uninitialized in this function [-Wuninitialized]
    1431 | #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
         |                                                     ^~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:76:18: note: 'skb' was declared here
      76 |  struct sk_buff *skb;
         |                  ^~~

vim +/skb +1431 include/linux/skbuff.h

4305b541357ddbd Arnaldo Carvalho de Melo 2007-04-19  1429  
^1da177e4c3f415 Linus Torvalds           2005-04-16  1430  /* Internal */
4305b541357ddbd Arnaldo Carvalho de Melo 2007-04-19 @1431  #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
^1da177e4c3f415 Linus Torvalds           2005-04-16  1432  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67660 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201209/92687b85/attachment-0001.bin>
