From: kbuild test robot <lkp@intel.com>
Date: Fri, 29 May 2020 11:10:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 160/177]
 include/linux/avf/virtchnl.h:809:31: error: enumerator value for
 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer
 constant
Message-ID: <202005291133.G5VPl22D%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ffc26e8fa1ec68b0f0e428fd3977ff87938c19de
commit: 560358c5b47c0f997336911f532d1ab29448b41b [160/177] virtchnl: Extend AVF ops
config: i386-randconfig-a013-20200528 (attached as .config)
compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
reproduce (this is a W=1 build):
        git checkout 560358c5b47c0f997336911f532d1ab29448b41b
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9:0,
from drivers/net/ethernet/intel/i40e/i40e.h:40,
from drivers/net/ethernet/intel/i40e/i40e_debugfs.c:9:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
>> include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
--
In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9:0,
from drivers/net/ethernet/intel/i40e/i40e.h:40,
from drivers/net/ethernet/intel/i40e/i40e_main.c:10:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
>> include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
In file included from drivers/net/ethernet/intel/i40e/i40e_trace.h:209:0,
from drivers/net/ethernet/intel/i40e/i40e_main.c:20:
include/trace/define_trace.h:95:43: fatal error: ./i40e_trace.h: No such file or directory
compilation terminated.
--
In file included from drivers/net/ethernet/intel/iavf/iavf.h:38:0,
from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
>> include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
^
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
^
In file included from drivers/net/ethernet/intel/iavf/iavf_trace.h:209:0,
from drivers/net/ethernet/intel/iavf/iavf_main.c:12:
include/trace/define_trace.h:95:43: fatal error: ./iavf_trace.h: No such file or directory
compilation terminated.

vim +/virtchnl_static_assert_virtchnl_get_capabilities +809 include/linux/avf/virtchnl.h

   808	
 > 809	VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
   810	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39835 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200529/6b0d0bf4/attachment-0001.bin>
