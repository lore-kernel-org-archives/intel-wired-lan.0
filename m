From: kernel test robot <lkp@intel.com>
Date: Tue, 09 Jun 2020 15:17:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 0d5373a5e8fe85107f1341ecf9e07e67e4e98111
Message-ID: <5edf37a6.iHKiHQ+FdaRs7Qbm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 0d5373a5e8fe85107f1341ecf9e07e67e4e98111  i40e: silence an UBSAN false positive

Error/Warning in current branch:

cc1: warning: drivers/net/ethernet/intel/idpf/../include: No such file or directory [-Wmissing-include-dirs]
drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: iecm.h: No such file or directory
drivers/net/ethernet/intel/iecm/iecm_lib.c:104:6: warning: no previous prototype for 'iecm_get_mb_vec_id' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:122:5: warning: no previous prototype for 'iecm_mb_intr_init' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:140:6: warning: no previous prototype for 'iecm_intr_distribute' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous prototype for 'iecm_vport_rel' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous prototype for 'iecm_mb_intr_clean' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:63:6: warning: no previous prototype for 'iecm_mb_irq_enable' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:748:6: warning: no previous prototype for 'iecm_deinit_task' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous prototype for 'iecm_mb_intr_req_irq' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:6: warning: no previous prototype for 'iecm_tx_desc_rel' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:6: warning: no previous prototype for 'iecm_tx_desc_rel_all' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:6: warning: no previous prototype for 'iecm_rx_buf_rel_all' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:341:6: warning: no previous prototype for 'iecm_rx_desc_rel' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3565:5: warning: no previous prototype for 'iecm_vport_splitq_napi_poll' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3603:6: warning: no previous prototype for 'iecm_vport_intr_map_vector_to_qs' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3715:5: warning: no previous prototype for 'iecm_vport_intr_alloc' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:371:6: warning: no previous prototype for 'iecm_rx_desc_rel_all' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:486:6: warning: no previous prototype for 'iecm_rx_hdr_buf_hw_alloc' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:12:6: warning: no previous prototype for 'iecm_recv_event_msg' [-Wmissing-prototypes]
drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:61:1: warning: no previous prototype for 'iecm_mb_clean' [-Wmissing-prototypes]
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- arc-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- arm-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- arm-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- arm64-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- arm64-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- i386-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- i386-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- i386-debian-10.3
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- i386-randconfig-a004-20200607
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- ia64-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- m68k-randconfig-r001-20200608
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- mips-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   `-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|-- mips-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   `-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|-- parisc-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- parisc-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- parisc-randconfig-r033-20200607
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- powerpc-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- powerpc-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- riscv-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- riscv-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- s390-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- s390-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|-- sparc-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc64-allmodconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc64-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- x86_64-allyesconfig
|   |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
|   |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
|   |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
|   `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg
`-- xtensa-allyesconfig
    |-- cc1:warning:drivers-net-ethernet-intel-idpf-..-include:No-such-file-or-directory
    |-- drivers-net-ethernet-intel-idpf-idpf_dev.h:fatal-error:iecm.h:No-such-file-or-directory
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_deinit_task
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_get_mb_vec_id
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_intr_distribute
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_clean
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_init
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_intr_req_irq
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_mb_irq_enable
    |-- drivers-net-ethernet-intel-iecm-iecm_lib.c:warning:no-previous-prototype-for-iecm_vport_rel
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_buf_rel_all
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_desc_rel_all
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_rx_hdr_buf_hw_alloc
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_buf_rel_all
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_tx_desc_rel_all
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_alloc
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_intr_map_vector_to_qs
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:warning:no-previous-prototype-for-iecm_vport_splitq_napi_poll
    |-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_mb_clean
    `-- drivers-net-ethernet-intel-iecm-iecm_virtchnl.c:warning:no-previous-prototype-for-iecm_recv_event_msg

elapsed time: 480m

configs tested: 121
configs skipped: 6

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          moxart_defconfig
arc                         haps_hs_defconfig
m68k                            mac_defconfig
c6x                               allnoconfig
arm                        oxnas_v6_defconfig
arm                         shannon_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
um                                allnoconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
alpha                               defconfig
arm                          exynos_defconfig
arm                            qcom_defconfig
sh                             espt_defconfig
powerpc                     mpc512x_defconfig
powerpc                          allmodconfig
h8300                       h8s-sim_defconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
m68k                       bvme6000_defconfig
arm                       omap2plus_defconfig
i386                             alldefconfig
s390                              allnoconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
s390                                defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a014-20200608
i386                 randconfig-a011-20200608
i386                 randconfig-a015-20200608
i386                 randconfig-a016-20200608
i386                 randconfig-a012-20200608
i386                 randconfig-a013-20200608
i386                 randconfig-a014-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
