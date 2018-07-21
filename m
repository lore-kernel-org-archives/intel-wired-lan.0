From: kbuild test robot <lkp@intel.com>
Date: Sat, 21 Jul 2018 13:53:26 +0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/2] ixgbe:
 Refactor queue disable logic to take completion time into account
In-Reply-To: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
References: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <201807211332.nSRytKFp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.18-rc5 next-20180720]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/ixgbe-Reorder-Tx-Rx-shutdown-to-reduce-time-needed-to-stop-device/20180721-074030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2723:19: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2723:19: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3181:35: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3205:16: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3205:16: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4823:16: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4990:29: sparse: expression using sizeof(void)
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:5608:15: sparse: symbol 'ixgbe_get_completion_timeout' was not declared. Should it be static?
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:6167:15: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:6167:15: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:6172:16: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8140:24: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8140:24: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9575:19: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9575:19: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9979:42: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9979:42: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9983:42: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9983:42: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10681:26: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10766:32: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
