From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:00 -0800
Subject: [Intel-wired-lan] [PATCH S14 00/15] Implementation updates for ice
Message-ID: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Brett Creeley (2):
  ice: Put __ICE_PREPARED_FOR_RESET check in ice_prepare_for_reset
  ice: Implement pci_error_handler ops

Bruce Allan (1):
  ice: add and use new ice_for_each_traffic_class() macro

Chinh T Cao (1):
  ice: Create a generic name for the ice_rx_flg64_bits structure

Dave Ertman (1):
  ice: Prevent unintended multiple chain resets

Jeremiah Kyle (1):
  ice: Remove unnecessary newlines from log messages

Maciej Fijalkowski (7):
  ice: Retrieve rx_buf in separate function
  ice: Pull out page reuse checks onto separate function
  ice: Get rid of ice_pull_tail
  ice: Introduce bulk update for page count
  ice: Gather the rx buf clean-up logic for better reuse
  ice: Limit the ice_add_rx_frag to frag addition
  ice: map rx buffer pages with DMA attributes

Mitch Williams (1):
  ice: use virt channel status codes

Preethi Banala (1):
  ice: change VF VSI tc info along with num_queues

 drivers/net/ethernet/intel/ice/ice_common.c      |  28 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  34 +--
 drivers/net/ethernet/intel/ice/ice_lib.c         |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 168 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_sched.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c        | 351 +++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_txrx.h        |   4 +
 drivers/net/ethernet/intel/ice/ice_type.h        |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 280 ++++++++++--------
 9 files changed, 563 insertions(+), 311 deletions(-)

-- 
2.14.5

