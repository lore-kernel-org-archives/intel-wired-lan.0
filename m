From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 23 Feb 2021 15:47:04 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 0/3] intel: packet type table
 simplification
Message-ID: <20210223234707.1170711-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update three of the Intel Ethernet drivers with similar (but not the
same) improvements to simplify the packet type table init, while removing
an unused structure entry. For the ice driver, the table is extended
to 10 bits, which is the hardware limit, and for now is initialized
to zero.

The end result is slightly reduced memory usage, removal of a bunch
of code, and more specific initialization.

Jesse Brandeburg (3):
  ice: report hash type such as L2/L3/L4
  i40e: clean up packet type lookup table
  iavf: clean up packet type lookup table

 drivers/net/ethernet/intel/i40e/i40e_common.c | 124 +--------------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 -
 drivers/net/ethernet/intel/iavf/iavf_common.c | 124 +--------------
 drivers/net/ethernet/intel/iavf/iavf_type.h   |   1 -
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 147 ++++--------------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  23 ++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 9 files changed, 62 insertions(+), 364 deletions(-)

-- 
2.29.2

