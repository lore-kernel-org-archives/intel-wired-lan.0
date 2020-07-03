From: kernel test robot <lkp@intel.com>
Date: Fri, 3 Jul 2020 17:08:21 +0800
Subject: [Intel-wired-lan] [PATCH S48 v3 10/14] ice: Support FDIR
 configure for AVF
In-Reply-To: <20200702225805.32167-11-qi.z.zhang@intel.com>
References: <20200702225805.32167-11-qi.z.zhang@intel.com>
Message-ID: <202007031723.hYsDk2tP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Qi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v5.8-rc3 next-20200703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qi-Zhang/Support-Advanced-AVF-features/20200703-070522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: m68k-randconfig-r026-20200702 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/skbuff.h:15,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:4:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/asm-generic/bug.h:144:27: note: in definition of macro 'WARN_ON_ONCE'
     144 |  int __ret_warn_once = !!(condition);   \
         |                           ^~~~~~~~~
   arch/m68k/include/asm/page_mm.h:170:25: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)  virt_addr_valid(pfn_to_virt(pfn))
         |                         ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
     352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                   ^~~~~~~~~
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:11:
   include/linux/avf/virtchnl.h: At top level:
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:949:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:949:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:957:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     957 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:957:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
     957 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:998:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     998 | VIRTCHNL_CHECK_STRUCT_LEN(2604, virtchnl_fdir_rule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:998:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_fdir_rule' is not an integer constant
     998 | VIRTCHNL_CHECK_STRUCT_LEN(2604, virtchnl_fdir_rule);
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1052:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1052 | VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1052:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_fdir_add' is not an integer constant
    1052 | VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1154:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1154 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1154:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
    1154 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1204:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1204 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1204:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_create_vport' is not an integer constant
    1204 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1236:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1236 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1236:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
    1236 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1252:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1252 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1252:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
    1252 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1282:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1282 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1282:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
    1282 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1297:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1297 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1297:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
    1297 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1315:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1315 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1315:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_add_queues' is not an integer constant
    1315 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1330:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1330 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1330:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_del_ena_dis_queues' is not an integer constant
    1330 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
--
   In file included from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/skbuff.h:15,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:4:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/asm-generic/bug.h:144:27: note: in definition of macro 'WARN_ON_ONCE'
     144 |  int __ret_warn_once = !!(condition);   \
         |                           ^~~~~~~~~
   arch/m68k/include/asm/page_mm.h:170:25: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)  virt_addr_valid(pfn_to_virt(pfn))
         |                         ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
     352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                   ^~~~~~~~~
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:11:
   include/linux/avf/virtchnl.h: At top level:
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:949:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:949:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:957:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     957 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:957:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
     957 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:998:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     998 | VIRTCHNL_CHECK_STRUCT_LEN(2604, virtchnl_fdir_rule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:998:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_fdir_rule' is not an integer constant
     998 | VIRTCHNL_CHECK_STRUCT_LEN(2604, virtchnl_fdir_rule);
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1052:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1052 | VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1052:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_fdir_add' is not an integer constant
    1052 | VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1154:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1154 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1154:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
    1154 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1204:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1204 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1204:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_create_vport' is not an integer constant
    1204 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1236:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1236 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1236:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
    1236 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1252:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1252 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1252:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
    1252 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1282:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1282 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1282:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
    1282 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1297:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1297 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1297:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
    1297 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1315:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1315 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1315:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_add_queues' is not an integer constant
    1315 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:186:36: warning: division by zero [-Wdiv-by-zero]
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1330:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1330 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1330:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_del_ena_dis_queues' is not an integer constant
    1330 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:186:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     186 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
..

vim +/virtchnl_static_assert_virtchnl_fdir_rule +998 include/linux/avf/virtchnl.h

   997	
 > 998	VIRTCHNL_CHECK_STRUCT_LEN(2604, virtchnl_fdir_rule);
   999	
  1000	/* Status returned to VF after VF requests FDIR commands
  1001	 * VIRTCHNL_FDIR_SUCCESS
  1002	 * VF FDIR related request is successfully done by PF
  1003	 * The request can be OP_ADD/DEL.
  1004	 *
  1005	 * VIRTCHNL_FDIR_FAILURE_RULE_NORESOURCE
  1006	 * OP_ADD_FDIR_FILTER request is failed due to no Hardware resource.
  1007	 *
  1008	 * VIRTCHNL_FDIR_FAILURE_RULE_EXIST
  1009	 * OP_ADD_FDIR_FILTER request is failed due to the rule is already existed.
  1010	 *
  1011	 * VIRTCHNL_FDIR_FAILURE_RULE_CONFLICT
  1012	 * OP_ADD_FDIR_FILTER request is failed due to conflict with existing rule.
  1013	 *
  1014	 * VIRTCHNL_FDIR_FAILURE_RULE_NONEXIST
  1015	 * OP_DEL_FDIR_FILTER request is failed due to this rule doesn't exist.
  1016	 *
  1017	 * VIRTCHNL_FDIR_FAILURE_RULE_INVALID
  1018	 * OP_ADD_FDIR_FILTER request is failed due to parameters validation
  1019	 * or HW doesn't support.
  1020	 *
  1021	 * VIRTCHNL_FDIR_FAILURE_RULE_TIMEOUT
  1022	 * OP_ADD/DEL_FDIR_FILTER request is failed due to timing out
  1023	 * for programming.
  1024	 */
  1025	enum virtchnl_fdir_prgm_status {
  1026		VIRTCHNL_FDIR_SUCCESS = 0,
  1027		VIRTCHNL_FDIR_FAILURE_RULE_NORESOURCE,
  1028		VIRTCHNL_FDIR_FAILURE_RULE_EXIST,
  1029		VIRTCHNL_FDIR_FAILURE_RULE_CONFLICT,
  1030		VIRTCHNL_FDIR_FAILURE_RULE_NONEXIST,
  1031		VIRTCHNL_FDIR_FAILURE_RULE_INVALID,
  1032		VIRTCHNL_FDIR_FAILURE_RULE_TIMEOUT,
  1033	};
  1034	
  1035	/* VIRTCHNL_OP_ADD_FDIR_FILTER
  1036	 * VF sends this request to PF by filling out vsi_id,
  1037	 * validate_only and rule_cfg. PF will return flow_id
  1038	 * if the request is successfully done and return add_status to VF.
  1039	 */
  1040	struct virtchnl_fdir_add {
  1041		u16 vsi_id;  /* INPUT */
  1042		/*
  1043		 * 1 for validating a fdir rule, 0 for creating a fdir rule.
  1044		 * Validate and create share one ops: VIRTCHNL_OP_ADD_FDIR_FILTER.
  1045		 */
  1046		u16 validate_only; /* INPUT */
  1047		u32 flow_id;       /* OUTPUT */
  1048		struct virtchnl_fdir_rule rule_cfg; /* INPUT */
  1049		enum virtchnl_fdir_prgm_status status; /* OUTPUT */
  1050	};
  1051	
> 1052	VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
  1053	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30039 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200703/c30d98d4/attachment-0001.bin>
