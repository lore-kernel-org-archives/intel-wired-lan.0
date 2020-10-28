From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 28 Oct 2020 13:19:33 -0700
Subject: [Intel-wired-lan] [PATCH v2 00/10] igc: Add XDP support
Message-ID: <20201028201943.93147-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series adds XDP support for the igc driver. For more context see the
cover letter from v1 in [1]. This v2 addresses the feedback received from the
community (thanks, Maciej Fijalkowski).

The main changes from v1 are:

	* Moved igc_rx_offset() changes to the patch the introduces XDP_PASS
	  action support.
	* Fixed uninitialized variable issue in igc_xdp_run_prog().
	* Changed wrapping code to avoid modulo operation.
	* Removed redundant xdp_rxq_info_unreg_mem_model() call.

A separated patch will be provided to address the comment about double VLAN
tagging in igc_change_mtu().

Best,
Andre

[1] https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201009025349.4037-1-andre.guedes at intel.com/

Andre Guedes (10):
  igc: Fix igc_ptp_rx_pktstamp()
  igc: Remove unused argument from igc_tx_cmd_type()
  igc: Introduce igc_rx_buffer_flip() helper
  igc: Introduce igc_get_rx_frame_truesize() helper
  igc: Refactor rx timestamp handling
  igc: Add set/clear large buffer helpers
  igc: Add initial XDP support
  igc: Add support for XDP_TX action
  igc: Add support for XDP_REDIRECT action
  igc: Implement ndo_xdp_xmit callback

 drivers/net/ethernet/intel/igc/Makefile   |   2 +-
 drivers/net/ethernet/intel/igc/igc.h      |  18 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 280 +++++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  89 +++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 205 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  27 +++
 6 files changed, 520 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_xdp.h

-- 
2.28.0

