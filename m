From: kernel test robot <lkp@intel.com>
Date: Sat, 20 Jun 2020 09:10:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 11/40]
 include/linux/avf/virtchnl.h:952:31: error: enumerator value for
 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer
 constant
Message-ID: <202006200950.bqdhQapw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   f97c28a0f623a6d300f7533466cb09c4f1e420af
commit: 15bffa9f7bce7fd38c84c962e8f43eded722e6ae [11/40] virtchnl: Extend AVF ops
config: arc-allyesconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 15bffa9f7bce7fd38c84c962e8f43eded722e6ae
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/ice/ice.h:36,
                    from drivers/net/ethernet/intel/ice/ice_main.c:8:
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
--
   In file included from drivers/net/ethernet/intel/ice/ice.h:36,
                    from drivers/net/ethernet/intel/ice/ice_common.h:7,
                    from drivers/net/ethernet/intel/ice/ice_flex_pipe.c:4:
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   In file included from drivers/net/ethernet/intel/ice/ice_flex_pipe.c:6:
   drivers/net/ethernet/intel/ice/ice_flex_pipe.c: In function 'ice_free_flow_profs':
   drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     197 | #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
         |                                 ^
   drivers/net/ethernet/intel/ice/ice_flex_pipe.c:2922:9: note: in expansion of macro 'ICE_FLOW_ENTRY_HNDL'
    2922 |         ICE_FLOW_ENTRY_HNDL(e));
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/intel/ice/ice.h:36,
                    from drivers/net/ethernet/intel/ice/ice_common.h:7,
                    from drivers/net/ethernet/intel/ice/ice_flow.c:4:
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   In file included from drivers/net/ethernet/intel/ice/ice_flow.c:5:
   drivers/net/ethernet/intel/ice/ice_flow.c: In function 'ice_flow_add_entry':
   drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     197 | #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
         |                                 ^
   drivers/net/ethernet/intel/ice/ice_flow.c:946:13: note: in expansion of macro 'ICE_FLOW_ENTRY_HNDL'
     946 |  *entry_h = ICE_FLOW_ENTRY_HNDL(e);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_flow.c: In function 'ice_flow_rem_entry':
   drivers/net/ethernet/intel/ice/ice_flow.h:198:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     198 | #define ICE_FLOW_ENTRY_PTR(h) ((struct ice_flow_entry *)(h))
         |                                ^
   drivers/net/ethernet/intel/ice/ice_flow.c:974:10: note: in expansion of macro 'ICE_FLOW_ENTRY_PTR'
     974 |  entry = ICE_FLOW_ENTRY_PTR(entry_h);
         |          ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:10:
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
     809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
     891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
     907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
     937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
         |                               ^~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
     952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                    ^
   include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
    1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
         |                               ^~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                     ^
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/net/ethernet/intel/i40e/i40e_trace.h:209,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:20:
   arch/arc/include/asm/perf_event.h:126:23: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                       ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~
..

vim +/virtchnl_static_assert_virtchnl_config_rx_queues +952 include/linux/avf/virtchnl.h

   951	
 > 952	VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
   953	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64639 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200620/0e9a0ef3/attachment-0001.bin>
