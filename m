From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 10 May 2021 11:38:48 +0200
Subject: [Intel-wired-lan] [PATCH intel-net v2 0/6] i40e: ice: ixgbe:
 ixgbevf: igb: igc: add correct exception tracing for XDP
Message-ID: <20210510093854.31652-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add missing exception tracing to XDP when a number of different errors
can occur. The support was only partial. Several errors where not
logged which would confuse the user quite a lot not knowing where and
why the packets disappeared.

This patch set fixes this for all Intel drivers with XDP support.

v1 -> v2:
* Applied fix to new XDP support in igc driver
* Rebased on latest net

Thanks: Magnus

Magnus Karlsson (6):
  i40e: add correct exception tracing for XDP
  ice: add correct exception tracing for XDP
  ixgbe: add correct exception tracing for XDP
  igb: add correct exception tracing for XDP
  ixgbevf: add correct exception tracing for XDP
  igc: add correct exception tracing for XDP

 drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c       |  8 ++++++--
 drivers/net/ethernet/intel/ice/ice_txrx.c        | 12 +++++++++---
 drivers/net/ethernet/intel/ice/ice_xsk.c         |  8 ++++++--
 drivers/net/ethernet/intel/igb/igb_main.c        | 10 ++++++----
 drivers/net/ethernet/intel/igc/igc_main.c        | 11 +++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 16 ++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     | 14 ++++++++------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c    |  3 +++
 9 files changed, 57 insertions(+), 32 deletions(-)


base-commit: b741596468b010af2846b75f5e75a842ce344a6e
--
2.29.0
