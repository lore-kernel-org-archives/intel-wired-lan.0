From: kernel test robot <lkp@intel.com>
Date: Mon, 7 Dec 2020 17:00:11 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ice: fix array overflow on
 receiving too many fragments for a packet
In-Reply-To: <20201207011415.463-1-ruc_zhangxiaohui@163.com>
References: <20201207011415.463-1-ruc_zhangxiaohui@163.com>
Message-ID: <202012071613.Ht9e6EB9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Xiaohui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on v5.10-rc7 next-20201204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xiaohui-Zhang/ice-fix-array-overflow-on-receiving-too-many-fragments-for-a-packet/20201207-141033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: riscv-allyesconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b3906f69dcad641195cbf1ce9af3e9105a6f72e1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xiaohui-Zhang/ice-fix-array-overflow-on-receiving-too-many-fragments-for-a-packet/20201207-141033
        git checkout b3906f69dcad641195cbf1ce9af3e9105a6f72e1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/vdso/processor.h:10,
                    from arch/riscv/include/asm/processor.h:11,
                    from include/linux/prefetch.h:15,
                    from drivers/net/ethernet/intel/ice/ice_txrx.c:6:
   arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
   arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
      14 |  barrier();
         |  ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_txrx.c: In function 'ice_add_rx_frag':
>> drivers/net/ethernet/intel/ice/ice_txrx.c:828:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     828 |  struct skb_shared_info *shinfo = skb_shinfo(skb);
         |  ^~~~~~
>> drivers/net/ethernet/intel/ice/ice_txrx.c:831:24: warning: passing argument 2 of 'skb_add_rx_frag' makes integer from pointer without a cast [-Wint-conversion]
     831 |   skb_add_rx_frag(skb, shinfo, rx_buf->page,
         |                        ^~~~~~
         |                        |
         |                        struct skb_shared_info *
   In file included from include/net/net_namespace.h:39,
                    from include/linux/netdevice.h:37,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from drivers/net/ethernet/intel/ice/ice_txrx.c:8:
   include/linux/skbuff.h:2187:47: note: expected 'int' but argument is of type 'struct skb_shared_info *'
    2187 | void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
         |                                           ~~~~^
   cc1: some warnings being treated as errors

vim +828 drivers/net/ethernet/intel/ice/ice_txrx.c

   825	
   826		if (!size)
   827			return;
 > 828		struct skb_shared_info *shinfo = skb_shinfo(skb);
   829	
   830		if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
 > 831			skb_add_rx_frag(skb, shinfo, rx_buf->page,
   832				rx_buf->page_offset, size, truesize);
   833		}
   834	
   835		/* page is being used so we must update the page offset */
   836		ice_rx_buf_adjust_pg_offset(rx_buf, truesize);
   837	}
   838	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67660 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201207/6bef576d/attachment-0001.bin>
