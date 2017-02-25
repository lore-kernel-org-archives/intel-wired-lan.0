From: kbuild test robot <lkp@intel.com>
Date: Sun, 26 Feb 2017 02:18:27 +0800
Subject: [Intel-wired-lan] [net-next PATCH 1/3] ixgbe: add XDP support
 for pass and drop actions
In-Reply-To: <20170225173229.32741.12321.stgit@john-Precision-Tower-5810>
Message-ID: <201702260208.B8iSdiap%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi John,

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on next-20170224]
[cannot apply to v4.10]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/John-Fastabend/XDP-for-ixgbe/20170226-013816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   In file included from arch/xtensa/include/asm/atomic.h:21:0,
                    from include/linux/atomic.h:4,
                    from include/linux/debug_locks.h:5,
                    from include/linux/lockdep.h:25,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/spinlock.h:81,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:30:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_setup_xdp_resource':
   arch/xtensa/include/asm/cmpxchg.h:139:3: warning: value computed is not used [-Wunused-value]
     ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
      ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:6165:2: note: in expansion of macro 'xchg'
     xchg(&ring->xdp_prog, adapter->xdp_prog);
     ^

vim +/xchg +6165 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  6149			goto err;
  6150	
  6151		rx_ring->next_to_clean = 0;
  6152		rx_ring->next_to_use = 0;
  6153	
  6154		return 0;
  6155	err:
  6156		vfree(rx_ring->rx_buffer_info);
  6157		rx_ring->rx_buffer_info = NULL;
  6158		dev_err(dev, "Unable to allocate memory for the Rx descriptor ring\n");
  6159		return -ENOMEM;
  6160	}
  6161	
  6162	static void ixgbe_setup_xdp_resource(struct ixgbe_adapter *adapter,
  6163					     struct ixgbe_ring *ring)
  6164	{
> 6165		xchg(&ring->xdp_prog, adapter->xdp_prog);
  6166	}
  6167	
  6168	/**
  6169	 * ixgbe_setup_all_rx_resources - allocate all queues Rx resources
  6170	 * @adapter: board private structure
  6171	 *
  6172	 * If this function returns with an error, then it's possible one or
  6173	 * more of the rings is populated (while the rest are not).  It is the

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48209 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170226/3d5a6f37/attachment-0001.bin>
