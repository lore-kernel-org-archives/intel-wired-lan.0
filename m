From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Tue, 26 Oct 2021 12:38:38 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/2] improve switchdev's slow-path
Message-ID: <20211026103840.11455-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset introduces new implementation of switchdev slow-path
which relies on advanced rules. That's why it also introduces
mechanism of replaying advanced rules which slow-path benefits from.

In current switchdev implementation, every VF PR is assigned to
individual ring on switchdev ctrl VSI. For slow-path traffic, there
is a mapping VF->ring done in software based on src_vsi value.

With this change, HW solution is introduced which is more
efficient. For each VF, src MAC (VF's MAC) filter will be created,
which forwards packets to the coresponding switchdev ctrl VSI queue
based on src MAC address.

Victor Raj (1):
  ice: replay advanced rules after reset

Wojciech Drewek (1):
  ice: improve switchdev's slow-path

 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 170 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  24 +--
 drivers/net/ethernet/intel/ice/ice_fltr.c     |  80 ---------
 drivers/net/ethernet/intel/ice/ice_fltr.h     |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  24 +++
 drivers/net/ethernet/intel/ice/ice_repr.c     |  17 ++
 drivers/net/ethernet/intel/ice/ice_repr.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  95 +++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   3 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  11 ++
 11 files changed, 260 insertions(+), 174 deletions(-)

-- 
2.31.1

