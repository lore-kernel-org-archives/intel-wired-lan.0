From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Aug 2020 00:34:38 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Set RX_ONLY mode for unicast
 promiscuous on VLAN
In-Reply-To: <20200806134059.11058-1-arkadiusz.kubalewski@intel.com>
References: <20200806134059.11058-1-arkadiusz.kubalewski@intel.com>
Message-ID: <BN6PR1101MB2145D57B0F71AC3E9E577C6A8C490@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Thursday, August 6, 2020 6:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Set RX_ONLY mode for unicast
> promiscuous on VLAN
> 
> From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> 
> Trusted VF with unicast promiscuous mode set, could listen to TX traffic of
> other VFs.
> Set unicast promiscuous mode to rx traffic, if VSI has port VLAN configured.
> Rename misleading I40E_AQC_SET_VSI_PROMISC_TX bit to
> I40E_AQC_SET_VSI_PROMISC_RX_ONLY. Aligned unicast promiscuous with
> VLAN to the one without VLAN.
> Previously, other trusted VFs with port VLAN could listen to unicast tx traffic
> of other VFs.
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +-
> drivers/net/ethernet/intel/i40e/i40e_common.c | 35 ++++++++++++++-----
>  2 files changed, 28 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


