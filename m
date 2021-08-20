From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 19 Aug 2021 17:08:47 -0700
Subject: [Intel-wired-lan] [next-queue v4 00/12] Add switchdev driver model
 for ice driver
Message-ID: <20210820000859.680522-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patch series introduces basic switchdev model
support in ice driver. Implement the following blocks of
switchdev framework:
- VF port representors creation
- control plane VSI definition 
- exception path (a. k. a. "slow-path") - to allow a virtual
switch or linux bridge to receive any packet that doesn't match
any hw filter
- link state management of virtual ports
- query virtual port statistics

Hardware offload support in switchdev mode is out of scope of
this patchset. Devlink interface is used to toggle between
switchdev and legacy (the default) modes of the driver.

Changelog:
 v4:
  * Squash in the following patches:
    ice: change devlink port number for pf
    ice: Fix crash in switchdev mode during VFR
    ice: disable VLAN stripping on control VSI
    ice: fix ethtool set channel when in switchdev mode
    ice: handle MAC delete command on PR
    ice: remove msleep from reading PR stats
 v3:
  * add more info to Kconfig ICE_SWITCHDEV flag
  * correct spealing  
 v2:
  * fix build issue in ice: set and release switchdev environment
  by moving call of ice_vsi_setup to next patch which have definition
  of switchdev VSI

Grzegorz Nitka (5):
  ice: set and release switchdev environment
  ice: introduce new type of VSI for switchdev
  ice: enable/disable switchdev when managing VFs
  ice: rebuild switchdev when resetting all VFs
  ice: switchdev slow path

Michal Swiatkowski (5):
  ice: support basic E-Switch mode control
  ice: introduce VF port representor
  ice: allow process VF opcodes in different ways
  ice: manage VSI antispoof and destination override
  ice: allow changing lan_en and lb_en on dflt rules

Wojciech Drewek (2):
  ice: Move devlink port to PF/VF struct
  ice: add port representor ethtool ops and stats

 drivers/net/ethernet/intel/Kconfig            |  14 +
 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 drivers/net/ethernet/intel/ice/ice.h          |  48 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  37 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   5 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 109 ++-
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   6 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 658 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  82 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  55 +-
 drivers/net/ethernet/intel/ice/ice_fltr.c     |  80 +++
 drivers/net/ethernet/intel/ice/ice_fltr.h     |   7 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  43 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      | 112 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |  11 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  47 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 333 +++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h     |  27 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   6 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 237 ++++++-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  58 ++
 25 files changed, 1895 insertions(+), 94 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_repr.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_repr.h

-- 
2.26.2

