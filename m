From: kernel test robot <lkp@intel.com>
Date: Thu, 11 Jun 2020 12:28:14 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 94e8b9f389d896ead02e9633104231fc864da9b0
Message-ID: <5ee1b2de.i7ql+JqF7nLWI34e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 94e8b9f389d896ead02e9633104231fc864da9b0  igc: Remove unneeded check for copper media type

Error/Warning in current branch:

cc1: warning: drivers/net/ethernet/intel/idpf/../include: No such file or directory [-Wmissing-include-dirs]
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2039 i40e_set_vsi_promisc() error: uninitialized symbol 'aq_ret'.
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
|-- mips-allmodconfig
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
|-- mips-allyesconfig
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
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-randconfig-m031-20200607
|   `-- drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c-i40e_set_vsi_promisc()-error:uninitialized-symbol-aq_ret-.
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

elapsed time: 605m

configs tested: 113
configs skipped: 9

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
sparc64                          allmodconfig
sh                           se7705_defconfig
mips                     decstation_defconfig
arm                              zx_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                          iop32x_defconfig
arm                            mps2_defconfig
openrisc                         allyesconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0219_defconfig
m68k                        mvme16x_defconfig
mips                          malta_defconfig
arm                         shannon_defconfig
um                                allnoconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
arm                          exynos_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200609
i386                 randconfig-a002-20200609
i386                 randconfig-a006-20200609
i386                 randconfig-a005-20200609
i386                 randconfig-a003-20200609
i386                 randconfig-a004-20200609
i386                 randconfig-a014-20200608
i386                 randconfig-a011-20200608
i386                 randconfig-a015-20200608
i386                 randconfig-a016-20200608
i386                 randconfig-a012-20200608
i386                 randconfig-a013-20200608
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                               allmodconfig
um                                  defconfig
um                               allyesconfig
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
