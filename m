From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue,  1 Jun 2021 13:32:34 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 0/2] ice: bring up XDP_TX back
 to life
Message-ID: <20210601113236.42651-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi there,

here are the improvements for handling the XDP_TX/REDIRECT actions in
ice driver. People have been recently reporting that they stumble upon a
situation where no packets are xmitted when they do XDP_TX from their
BPF programs - first patch addresses that.

Second patch handles the case where we could not have XDP ring per core.
Let's consider that as a starting point of fixing Intel drivers against
that scenario.

Note that this is based on the series that I sent two weeks ago:
https://lore.kernel.org/bpf/20210520063500.62037-1-maciej.fijalkowski at intel.com/

Parametrizing of ice_vsi_cfg_txqs/ice_vsi_stop_tx_rings is needed for a
fallback path.

Thanks!

Maciej Fijalkowski (2):
  ice: unify xdp_rings accesses
  ice: introduce XDP Tx fallback path

 drivers/net/ethernet/intel/ice/ice.h          | 37 +++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |  5 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 76 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 62 ++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 13 +++-
 7 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.20.1

