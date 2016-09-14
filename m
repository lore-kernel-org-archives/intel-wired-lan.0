From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 14 Sep 2016 16:24:30 -0700
Subject: [Intel-wired-lan] [next PATCH S47 0/9] i40e/i40evf updates
Message-ID: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to fix interrupt affinity bug.

Alexander Duyck rewrites Flow Director busy wait loop, removes unused 
function i40e_vsi_lookup and drops code for unsupported flow types.

Bimmy Pujari changes version from 1.6.16 to 1.6.19

Carolyn Wyborny adds code to fix client interaction.

Filip Sadowski adds code for bit test mask correction.

Mitch Williams adds code to reopen client after reset.

Preethi Banala adds code for group based mode VF offload flags.

 drivers/net/ethernet/intel/i40e/i40e.h            |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c     | 85 +++++------------------
 drivers/net/ethernet/intel/i40e/i40e_client.h     |  2 -
 drivers/net/ethernet/intel/i40e/i40e_common.c     |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 66 ++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 80 ++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   |  4 ++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     | 31 +++++++--
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h |  4 ++
 drivers/net/ethernet/intel/i40evf/i40evf.h        |  3 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   | 73 +++++++++++++------
 11 files changed, 198 insertions(+), 156 deletions(-)

-- 
2.4.11

