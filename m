From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 22 Jan 2021 18:33:35 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] ice: Don't allow more
 channels than LAN MSI-X available
In-Reply-To: <20210121183806.23030-1-brett.creeley@intel.com>
References: <20210121183806.23030-1-brett.creeley@intel.com>
Message-ID: <CO1PR11MB510587057BC9603577D272CBFAA09@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Brett Creeley
Sent: Thursday, January 21, 2021 10:38 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH net 1/2] ice: Don't allow more channels than LAN MSI-X available

Currently users could create more channels than LAN MSI-X available.
This is happening because there is no check against pf->num_lan_msix when checking the max allowed channels and will cause performance issues if multiple Tx and Rx queues are tied to a single MSI-X. Fix this by not allowing more channels than LAN MSI-X available in pf->num_lan_msix.

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 41427302332c..aebebd2102da 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
