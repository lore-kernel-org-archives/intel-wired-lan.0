From: kernel test robot <lkp@intel.com>
Date: Mon, 12 Oct 2020 12:02:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 92/106]
 include/linux/avf/virtchnl.h:837:31: error: enumerator value for
 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer
 constant
Message-ID: <202010121212.23aecglp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   977a109bc3e30ee6303dd767090e04eb5170e986
commit: a91a603ad19cb4845b671efb13581b70f2d35dae [92/106] virtchnl: Extend AVF ops
config: m68k-randconfig-r021-20201012 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=a91a603ad19cb4845b671efb13581b70f2d35dae
        git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
        git fetch --no-tags jkirsher-next-queue dev-queue
        git checkout a91a603ad19cb4845b671efb13581b70f2d35dae
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/intel/iavf/iavf.h:7,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:38,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
   include/linux/avf/virtchnl.h: At top level:
>> include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:837:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:837:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   In file included from drivers/net/ethernet/intel/iavf/iavf_trace.h:209,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:12:
   include/trace/define_trace.h:95:42: fatal error: ./iavf_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/intel/iavf/iavf.h:7,
                    from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:38,
                    from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   include/linux/avf/virtchnl.h: At top level:
>> include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:837:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:837:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
--
   In file included from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:4:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:41,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:11:
   include/linux/avf/virtchnl.h: At top level:
>> include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:837:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:837:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     837 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_trace.h:209,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:21:
   include/trace/define_trace.h:95:42: fatal error: ./i40e_trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.

vim +/virtchnl_static_assert_virtchnl_get_capabilities +837 include/linux/avf/virtchnl.h

   836	
 > 837	VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
   838	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35567 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201012/e68fab54/attachment-0001.bin>
