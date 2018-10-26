From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:32 -0700
Subject: [Intel-wired-lan] [PATCH S9 00/15] Bug fixes for ice, set 2/2
Message-ID: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (1):
  ice: Do autoneg based on VSI state

Anirudh Venkataramanan (2):
  ice: Cosmetic formatting changes
  ice: Use Tx|Rx in comments

Brett Creeley (1):
  ice: Call pci_disable_sriov before stopping queues for VF

Bruce Allan (4):
  ice: Cleanup duplicate control queue code
  ice: Constify global structures that can/should be
  ice: Cleanup ice_tx_timeout()
  ice: Cleanup short function signatures

Dave Ertman (1):
  ice: Fix return value from NAPI poll

Henry Tieman (1):
  ice: Destroy scheduler tree in reset path

Jaroslaw Ilgiewicz (1):
  ice: Pass the return value of ice_init_def_sw_recp().

Md Fahad Iqbal Polash (1):
  ice: Remove ICE_MAX_TXQ_PER_TXQG check when configuring Tx queue

Piotr Raczynski (1):
  ice: Increase rx queue disable timeout

Usha Ketineni (1):
  ice: Fix to make VLAN priority tagged traffic to appear on all TCs

Yashaswini Raghuram Prathivadi Bhayankaram (1):
  ice: Do not set LAN_EN for MAC-VLAN filters

 drivers/net/ethernet/intel/ice/ice.h             |  34 ++--
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  16 +-
 drivers/net/ethernet/intel/ice/ice_common.c      |  13 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c    | 223 ++++++++---------------
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  26 +--
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  79 ++++----
 drivers/net/ethernet/intel/ice/ice_lib.c         | 148 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c        |  42 ++---
 drivers/net/ethernet/intel/ice/ice_sched.c       |  14 +-
 drivers/net/ethernet/intel/ice/ice_sched.h       |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c      |  52 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  36 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  34 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   2 +-
 15 files changed, 342 insertions(+), 380 deletions(-)

-- 
2.14.3

