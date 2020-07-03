From: kernel test robot <lkp@intel.com>
Date: Fri, 3 Jul 2020 15:37:37 +0800
Subject: [Intel-wired-lan] [PATCH S48 v3 07/14] ice: Enable RSS
 Configure for AVF
In-Reply-To: <20200702225805.32167-8-qi.z.zhang@intel.com>
References: <20200702225805.32167-8-qi.z.zhang@intel.com>
Message-ID: <202007031526.s2aTj2Aq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Qi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v5.8-rc3 next-20200702]
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
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:941:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:941:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:949:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:949:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1038:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1038:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1088:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1088:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_create_vport' is not an integer constant
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1120:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1120:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1136:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1136:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1166:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1166:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1181:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1181:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1199:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1199:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_add_queues' is not an integer constant
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1214:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1214:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_del_ena_dis_queues' is not an integer constant
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
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
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:941:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:941:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:949:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:949:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1038:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1038:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1088:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1088:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_create_vport' is not an integer constant
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1120:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1120:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1136:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1136:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1166:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1166:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1181:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1181:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1199:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1199:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_add_queues' is not an integer constant
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1214:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1214:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_del_ena_dis_queues' is not an integer constant
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
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
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/ethernet/intel/iavf/iavf.h:7,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
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
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:38,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
   include/linux/avf/virtchnl.h: At top level:
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:941:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:941:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_proto_hdrs' is not an integer constant
     941 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:949:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:949:33: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_cfg' is not an integer constant
     949 | VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1038:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1038:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
    1038 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1088:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1088:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_create_vport' is not an integer constant
    1088 | VIRTCHNL_CHECK_STRUCT_LEN(56, virtchnl_create_vport);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1120:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1120:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
    1120 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1136:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1136:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
    1136 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1166:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1166:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
    1166 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1181:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1181:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
    1181 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1199:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1199:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_add_queues' is not an integer constant
    1199 | VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:184:36: warning: division by zero [-Wdiv-by-zero]
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1214:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1214:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_del_ena_dis_queues' is not an integer constant
    1214 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:184:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     184 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }

vim +/virtchnl_static_assert_virtchnl_proto_hdrs +941 include/linux/avf/virtchnl.h

   940	
 > 941	VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
   942	
   943	struct virtchnl_rss_cfg {
   944		struct virtchnl_proto_hdrs proto_hdrs;	   /* protocol headers */
   945		enum virtchnl_rss_algorithm rss_algorithm; /* rss algorithm type */
   946		u8 reserved[128];                          /* reserve for future */
   947	};
   948	
 > 949	VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
   950	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30039 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200703/9cafcd68/attachment-0001.bin>
