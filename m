From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri,  6 Aug 2021 01:00:40 +0200
Subject: [Intel-wired-lan] [PATCH v3 intel-next 0/6] XDP_TX improvements for
 ice
Message-ID: <20210805230046.28715-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

it's been a while. Here's another revision of XDP_TX improvements for
ice. This time I decided to split the generic ring struct that was
serving both Tx and Rx sides onto separate entities. It is due to the
fact that this set introduces few Tx specific fields onto ring.

Also, when compared to v2, Xdp ring is propagated onto Rx ring.
Accessing vsi->xdp_rings array, especially in fallback path, is not
convenient.

Finally patch 5 introduces yet another cleaning logic, different from
v2. For more info please see commit messages.

Thanks!
Maciej

v2 : https://lore.kernel.org/bpf/20210705164338.58313-1-maciej.fijalkowski at intel.com/
v1 : https://lore.kernel.org/bpf/20210601113236.42651-1-maciej.fijalkowski at intel.com/

Maciej Fijalkowski (6):
  ice: split ice_ring onto Tx/Rx separate structs
  ice: unify xdp_rings accesses
  ice: do not create xdp_frame on XDP_TX
  ice: propagate xdp_ring onto rx_ring
  ice: optimize XDP_TX workloads
  ice: introduce XDP_TX fallback path

 drivers/net/ethernet/intel/ice/ice.h          |  30 +++-
 drivers/net/ethernet/intel/ice/ice_base.c     |  27 ++--
 drivers/net/ethernet/intel/ice/ice_base.h     |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   6 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  32 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 101 +++++++++----
 drivers/net/ethernet/intel/ice/ice_trace.h    |   8 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 139 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  94 +++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  86 +++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   8 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  52 ++++---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   8 +-
 17 files changed, 408 insertions(+), 217 deletions(-)

-- 
2.20.1

