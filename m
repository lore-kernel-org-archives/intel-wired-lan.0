From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:08 -0700
Subject: [Intel-wired-lan] [next PATCH S36 00/12] i40e/i40evf updates
Message-ID: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin corrects UDP packet header for non_tunnel ipv6.

Anjali Singhai Jain adds allmulti support for the VF and
vf-true-promisc-support priv flag.

Catherine Sullivan refactors ethtool get_settings.

Jacob Keller changes Rx hang message into a WARN_ONCE.

Kevin Scott & Carolyn Wyborny add support for disabling all link and change
bits needed for PHY interactions.

Mitch Williams adds code to lie to the VF, properly report rx packet hash 
and adds code for not adding broadcast filter for VFs.

Ashish Shah sets context to use VSI RSS Lut for SR-IOV.

Shannon Nelson implements the API function for aq_set_switch_config.

 drivers/net/ethernet/intel/i40e/i40e.h             |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   3 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  40 ++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 332 +++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  35 ++-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  21 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   3 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  15 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  15 +-
 12 files changed, 329 insertions(+), 164 deletions(-)

-- 
2.4.11

