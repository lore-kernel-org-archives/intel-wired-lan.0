From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:31 -0800
Subject: [Intel-wired-lan] [next PATCH S59 0/6] i40e/i40evf updates
Message-ID: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck adds support for mapping pages with DMA attributes.

Bimmy Pujari changes version from 1.6.27 to 2.1.7.

Filip Sadowski adds code to clarify steps in MAC/VLAN filters 
initialization routine.

Lihong Yang adds code to fix ethtool to get EEPROM data from X722 
interface and fixes RSS queues only operating on PF0.

Mitch Williams adds code to allow untrusted VFs to have more filters.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  5 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 25 +++++++----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 31 ++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  3 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 +++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 31 ++++++++++++++++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  3 +++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  6 ++---
 8 files changed, 79 insertions(+), 33 deletions(-)

-- 
2.4.11

