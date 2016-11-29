From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:05:57 -0800
Subject: [Intel-wired-lan] [next PATCH S55 00/14] i40e/i40evf updates
Message-ID: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to refactor macro INTRL_USEC_TO_REG and adds code
to add interrupt rate limit verbosity.

Alexander Duyck adds code for quick refactor to start moving data off
stack and into Tx buffer info.

Bimmy Pujari changes version from 1.6.25 to 1.6.27.

Faisal Latif adds code to fix client warnings.

Filip Sadowski adds code to disable ntuple filters to clean Cloud 
Filters.

Jacob Keller adds code to not check params until after checking for 
client instance and updates comment explaining where FDIR buffers 
are freed.

Jayaprakash Shanmugam removes FPK HyperV VF device ID.

Mitch Williams removes unused function and adds code to track
outstanding client request.

Scott Peterson adds code to limit dma sync of RX buffers to actual
packet size, moves skb from i40e_rx_buffer to i40e_ring and eliminates
i40e_pull_tail().

 drivers/net/ethernet/intel/i40e/i40e.h             |  40 ++-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |  39 +--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  18 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 270 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  24 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 262 +++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   9 +-
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |   1 +
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   8 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   2 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 +
 14 files changed, 416 insertions(+), 288 deletions(-)

-- 
2.4.11

