From: kernel test robot <lkp@intel.com>
Date: Thu, 11 Jun 2020 15:21:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 11/55]
 include/linux/avf/virtchnl.h:872:30: error: enumerator value for
 'virtchnl_static_assert_virtchnl_vport' is not an integer constant
Message-ID: <202006111507.xEY4Qu64%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   94e8b9f389d896ead02e9633104231fc864da9b0
commit: 2498cdba2cbf1af8fa4ff479b981e2e2240e2a46 [11/55] virtchnl: Extend AVF ops
config: arm-randconfig-r004-20200611 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2498cdba2cbf1af8fa4ff479b981e2e2240e2a46
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

|                                                 ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:299:32: warning: division by zero [-Wdiv-by-zero]
299 |  { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:304:34: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
304 | #define I40E_CHECK_CMD_LENGTH(X) I40E_CHECK_STRUCT_LEN(16, X)
|                                  ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1775:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
1775 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
| ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1775:23: error: enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is not an integer constant
1775 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
|                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:299:49: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
299 |  { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                 ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1775:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
1775 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
| ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:299:32: warning: division by zero [-Wdiv-by-zero]
299 |  { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1914:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
1914 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
| ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1914:28: error: enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer constant
1914 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
|                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:299:49: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
299 |  { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                 ^
In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
from drivers/net/ethernet/intel/i40e/i40e.h:40,
from drivers/net/ethernet/intel/i40e/i40e_main.c:10:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:403:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
403 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:403:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
403 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
|                               ^~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:469:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
469 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:469:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
469 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
|                              ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:525:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
525 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:525:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
525 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
|                              ^~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:534:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
534 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:534:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
534 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
|                              ^~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
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
include/linux/avf/virtchnl.h:872:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
872 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_vport);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:872:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vport' is not an integer constant
872 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_vport);
|                              ^~~~~~~~~~~~~~
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
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1034:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1034 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vector_chunks);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1034:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vector_chunks' is not an integer constant
1034 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vector_chunks);
|                              ^~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1048:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1048 | VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_alloc_vectors);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1048:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_alloc_vectors' is not an integer constant
1048 | VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_alloc_vectors);
|                              ^~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1068:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1068 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut_v2);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1068:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut_v2' is not an integer constant
1068 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut_v2);
|                              ^~~~~~~~~~~~~~~~~~~
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
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1103:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1103 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_sriov_vfs_info);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1103:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_sriov_vfs_info' is not an integer constant
1103 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_sriov_vfs_info);
|                              ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
--
In file included from drivers/net/ethernet/intel/ice/ice.h:36,
from drivers/net/ethernet/intel/ice/ice_main.c:8:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:403:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
403 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:403:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
403 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
|                               ^~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:469:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
469 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:469:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
469 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
|                              ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:525:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
525 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:525:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
525 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
|                              ^~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:534:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
534 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:534:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
534 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
|                              ^~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
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
include/linux/avf/virtchnl.h:872:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
872 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_vport);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:872:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vport' is not an integer constant
872 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_vport);
|                              ^~~~~~~~~~~~~~
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
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1034:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1034 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vector_chunks);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1034:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vector_chunks' is not an integer constant
1034 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vector_chunks);
|                              ^~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1048:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1048 | VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_alloc_vectors);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1048:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_alloc_vectors' is not an integer constant
1048 | VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_alloc_vectors);
|                              ^~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1068:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1068 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut_v2);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1068:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut_v2' is not an integer constant
1068 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut_v2);
|                              ^~~~~~~~~~~~~~~~~~~
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
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1103:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1103 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_sriov_vfs_info);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:1103:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_sriov_vfs_info' is not an integer constant
1103 | VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_sriov_vfs_info);
|                              ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
..

vim +/virtchnl_static_assert_virtchnl_vport +872 include/linux/avf/virtchnl.h

   871	
 > 872	VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_vport);
   873	
   874	/* Tx queue config info */
   875	struct virtchnl_txq_info_v2 {
   876	        u16 queue_id;
   877	        /* single or split */
   878	        enum virtchnl_queue_model model;
   879	        /* tx or tx_completion */
   880	        enum virtchnl_queue_type type;
   881	        /* queue or flow based */
   882	        enum virtchnl_txq_sched_mode sched_mode;
   883	        /* base or native */
   884	        enum virtchnl_desc_profile desc_profile;
   885	        u16 ring_len;
   886	        u64 dma_ring_addr;
   887	        /* valid only if queue model is split and type is tx */
   888	        u16 tx_compl_queue_id;
   889	};
   890	
   891	VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
   892	
   893	/* VIRTCHNL_OP_CONFIG_TX_QUEUES
   894	 * PF sends this message to set up parameters for one or more TX queues.
   895	 * This message contains an array of num_qinfo instances of virtchnl_txq_info_v2
   896	 * structures. CP configures requested queues and returns a status code. If
   897	 * num_qinfo specified is greater than the number of queues associated with the
   898	 * vport, an error is returned and no queues are configured.
   899	 */
   900	struct virtchnl_config_tx_queues {
   901	        u16 vport_id;
   902	        u16 num_qinfo;
   903	        u32 rsvd;
   904	        struct virtchnl_txq_info_v2 qinfo[1];
   905	};
   906	
   907	VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
   908	
   909	/* Rx queue config info */
   910	struct virtchnl_rxq_info_v2 {
   911	        u16 queue_id;
   912	        /* single or split */
   913	        enum virtchnl_queue_model model;
   914	        /* rx or rx buffer */
   915	        enum virtchnl_queue_type type;
   916	        /* base or native */
   917	        enum virtchnl_desc_profile desc_profile;
   918	        /* rsc, header-split, immediate write back */
   919	        u16 queue_flags;
   920	        /* 16 or 32 byte */
   921	        enum virtchnl_rxq_desc_size desc_size;
   922	        u16 ring_len;
   923	        u16 hdr_buffer_size;
   924	        u32 data_buffer_size;
   925	        u32 max_pkt_size;
   926	        u64 dma_ring_addr;
   927	        u64 dma_head_wb_addr;
   928	        u16 rsc_low_watermark;
   929	        u8 buffer_notif_stride;
   930	        enum virtchnl_rx_hsplit rx_split_pos;
   931	        /* valid only if queue model is split and type is rx buffer*/
   932	        u16 rx_bufq1_id;
   933	        /* valid only if queue model is split and type is rx buffer*/
   934	        u16 rx_bufq2_id;
   935	};
   936	
   937	VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
   938	
   939	/* VIRTCHNL_OP_CONFIG_RX_QUEUES
   940	 * PF sends this message to set up parameters for one or more RX queues.
   941	 * This message contains an array of num_qinfo instances of virtchnl_rxq_info_v2
   942	 * structures. CP configures requested queues and returns a status code.
   943	 * If the number of queues specified is greater than the number of queues
   944	 * associated with the vport, an error is returned and no queues are configured.
   945	 */
   946	struct virtchnl_config_rx_queues {
   947	        u16 vport_id;
   948	        u16 num_qinfo;
   949	        struct virtchnl_rxq_info_v2 qinfo[1];
   950	};
   951	
   952	VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
   953	
   954	/* VIRTCHNL_OP_ADD_QUEUES
   955	 * PF sends this message to request additional TX/RX queues beyond the ones
   956	 * that were assigned via CREATE_VPORT request. virtchnl_add_queues structure is
   957	 * used to specify the number of each type of queues.
   958	 * CP responds with the same structure with the actual number of queues assigned
   959	 * followed by num_chunks of virtchnl_queue_chunk structures.
   960	 */
   961	struct virtchnl_add_queues {
   962	        u16 vport_id;
   963	        u16 num_tx_q;
   964	        u16 num_tx_complq;
   965	        u16 num_rx_q;
   966	        u16 num_rx_bufq;
   967	        struct virtchnl_queue_chunks chunks;
   968	};
   969	
   970	VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_add_queues);
   971	
   972	/* VIRTCHNL_OP_ENABLE_QUEUES
   973	 * VIRTCHNL_OP_DISABLE_QUEUES
   974	 * VIRTCHNL_OP_DEL_QUEUES
   975	 * PF sends these messages to enable, disable or delete queues specified in
   976	 * chunks. PF sends virtchnl_del_ena_dis_queues struct to specify the queues
   977	 * to be enabled/disabled/deleted. Also applicable to single queue RX or
   978	 * TX. CP performs requested action and returns status.
   979	 */
   980	struct virtchnl_del_ena_dis_queues {
   981	        u16 vport_id;
   982	        struct virtchnl_queue_chunks chunks;
   983	};
   984	
   985	VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_del_ena_dis_queues);
   986	
   987	/* Virtchannel interrupt throttling rate index */
   988	enum virtchnl_itr_idx {
   989	       VIRTCHNL_ITR_IDX_0      = 0,
   990	       VIRTCHNL_ITR_IDX_1      = 1,
   991	       VIRTCHNL_ITR_IDX_NO_ITR = 3,
   992	};
   993	
   994	/* Queue to vector mapping */
   995	struct virtchnl_queue_vector {
   996	        u16 queue_id;
   997	        u16 vector_id;
   998	        enum virtchnl_itr_idx itr_idx;
   999	        enum virtchnl_queue_type queue_type;
  1000	};
  1001	
  1002	VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_queue_vector);
  1003	
  1004	/* VIRTCHNL_OP_MAP_QUEUE_VECTOR
  1005	 * VIRTCHNL_OP_UNMAP_QUEUE_VECTOR
  1006	 * PF sends this message to map or unmap queues to vectors and ITR index
  1007	 * registers. External data buffer contains virtchnl_queue_vector_maps structure
  1008	 * that contains num_maps of virtchnl_queue_vector structures.
  1009	 * CP maps the requested queue vector maps after validating the queue and vector
  1010	 * ids and returns a status code.
  1011	 */
  1012	struct virtchnl_queue_vector_maps {
  1013	       u16 vport_id;
  1014	       u16 num_maps;
  1015	       struct virtchnl_queue_vector qv_maps[1];
  1016	};
  1017	
  1018	VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_queue_vector_maps);
  1019	
  1020	/* Structure to specify a chunk of contiguous interrupt vectors */
  1021	 struct virtchnl_vector_chunk {
  1022	        u16 start_vector_id;
  1023	        u16 num_vectors;
  1024	};
  1025	
  1026	VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_vector_chunk);
  1027	
  1028	/* Structure to specify several chunks of contiguous interrupt vectors */
  1029	struct virtchnl_vector_chunks {
  1030	        u16 num_vector_chunks;
  1031	        struct virtchnl_vector_chunk num_vchunk[1];
  1032	};
  1033	
> 1034	VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vector_chunks);
  1035	
  1036	/* VIRTCHNL_OP_ALLOC_VECTORS
  1037	 * PF sends this message to request additional interrupt vectors beyond the
  1038	 * ones that were assigned via GET_CAPS request. virtchnl_alloc_vectors
  1039	 * structure is used to specify the number of vectors requested. CP responds
  1040	 * with the same structure with the actual number of vectors assigned followed
  1041	 * by virtchnl_vector_chunks structure identifying the vector ids.
  1042	 */
  1043	struct virtchnl_alloc_vectors {
  1044	        u16 num_vectors;
  1045	        struct virtchnl_vector_chunks vchunks;
  1046	};
  1047	
> 1048	VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_alloc_vectors);
  1049	
  1050	/* VIRTCHNL_OP_DEALLOC_VECTORS
  1051	 * PF sends this message to release the vectors.
  1052	 * PF sends virtchnl_vector_chunks struct to specify the vectors it is giving
  1053	 * away. CP performs requested action and returns status.
  1054	 */
  1055	
  1056	/* VIRTCHNL_OP_GET_RSS_LUT
  1057	 * VIRTCHNL_OP_SET_RSS_LUT
  1058	 * PF sends this message to get or set RSS lookup table. Only supported if
  1059	 * both PF and CP drivers set the VIRTCHNL_CAP_RSS bit during configuration
  1060	 * negotiation. Uses the virtchnl_rss_lut_v2 structure
  1061	 */
  1062	struct virtchnl_rss_lut_v2 {
  1063	        u16 vport_id;
  1064	        u16 lut_entries;
  1065	        u16 lut[1]; /* RSS lookup table */
  1066	};
  1067	
> 1068	VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut_v2);
  1069	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34941 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200611/b8ccc331/attachment-0001.bin>
