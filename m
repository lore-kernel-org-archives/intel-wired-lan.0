From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 31 Jul 2018 20:47:16 -0700
Subject: [Intel-wired-lan] [PATCH v3 00/13] Bug fixes for ice
Message-ID: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set fixes multiple bugs for the ice driver.

Anirudh Venkataramanan (4):
  ice: Fix multiple static analyser warnings
  ice: Cleanup magic number
  ice: Fix bugs in control queue processing
  ice: Fix couple of null pointer dereference issues

Brett Creeley (2):
  ice: Don't explicitly set port_vlan_bits to 0
  ice: Set VLAN flags correctly

Bruce Allan (3):
  ice: Remove unncessary node owner check
  ice: Update to interrupts enabled in OICR
  ice: Change struct members from bool to u8

Jacob Keller (2):
  ice: Report stats for allocated queues via ethtool stats
  ice: Use order_base_2 to calculate higher power of 2

Jesse Brandeburg (1):
  ice: Fix potential return of uninitialized value

Preethi Banala (1):
  ice: Clean control queues only when they are initialized

 drivers/net/ethernet/intel/ice/ice.h          | 15 +++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 25 +++---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 29 +++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 52 ++++++++---
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  8 --
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 87 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sched.c    |  3 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  4 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |  6 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     | 16 ++--
 13 files changed, 152 insertions(+), 97 deletions(-)

-- 
2.17.1

