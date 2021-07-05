From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon,  5 Jul 2021 18:43:34 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-next 0/4] XDP_TX improvements for
 ice
Message-ID: <20210705164338.58313-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

this is a second revision of a series around XDP_TX improvements for ice
driver. When compared to v1 (which can be found under [1]), two new
patches are introduced that are focused on improving the performance for
XDP_TX as Jussi reported that the numbers were pretty low on his side.
Furthermore the fallback path is now based on static branch, as
suggested by Toke on v1. This means that there's no further need for a
standalone net_device_ops that were serving the locked version of
ndo_xdp_xmit callback.

Idea from 2nd patch is borrowed from a joint work that was done against
OOT driver among with Sridhar Samudrala, Jesse Brandeburg and Piotr
Raczynski, where we working on fixing the scaling issues for Tx AF_XDP
ZC path.

Last but not least, with this series I observe the improvement of
performance by around 30%.

Thanks!
Maciej

[1] : https://lore.kernel.org/bpf/20210601113236.42651-1-maciej.fijalkowski at intel.com/

Maciej Fijalkowski (4):
  ice: unify xdp_rings accesses
  ice: optimize XDP_TX descriptor processing
  ice: do not create xdp_frame on XDP_TX
  ice: introduce XDP_TX fallback path

 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  45 ++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 123 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   6 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  29 +++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  16 +++
 7 files changed, 190 insertions(+), 36 deletions(-)

-- 
2.20.1

