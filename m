From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  2 Dec 2016 12:32:54 -0800
Subject: [Intel-wired-lan] [next PATCH S56 0/8] i40e/i40evf updates
Message-ID: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Aaron Salter changes code to acquire NVM lock before reads on all
devices.

Henry Tieman adds code to save link FEC info from link up event and
adds code to save more link abilities when using ethtool.

Jacob Keller adds code to not warn every time we clear an Rx timestamp
register, adds code to fix i40e_update_filter_state to skip broadcast
filters and adds code to avoid race condition when sending filters to
firmware for addition.

Mitch Williams removes dead code.

Sudheer Mogilappagari adds bus number info to i40e_bus_info struct.

 drivers/net/ethernet/intel/i40e/i40e.h          |  16 ++
 drivers/net/ethernet/intel/i40e/i40e_client.c   |  29 ++--
 drivers/net/ethernet/intel/i40e/i40e_common.c   |   2 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  |   3 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 190 +++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c      |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h    |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  21 ++-
 drivers/net/ethernet/intel/i40e/i40e_type.h     |   2 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h   |   2 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   1 +
 11 files changed, 203 insertions(+), 87 deletions(-)

-- 
2.4.11

