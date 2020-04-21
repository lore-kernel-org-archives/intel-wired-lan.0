From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 23:48:29 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] igc: Refactor VLAN priority
 filtering code
In-Reply-To: <20200403181743.23447-5-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
 <20200403181743.23447-5-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890CEC1469CA37FE956BE35BCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 3, 2020 11:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/4] igc: Refactor VLAN priority filtering
> code
> 
> The whole VLAN priority filtering code is implemented in igc_ethtool.c
> and mixes logic from ethtool and core parts. This patch refactors it so
> core logic is moved to igc_main.c, aligning the VLAN priority filtering
> code organization with the MAC address filtering code.
> 
> This patch also takes the opportunity to add some log messages to ease
> debugging.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  3 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 64 ++++----------------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 52 ++++++++++++++++
>  3 files changed, 68 insertions(+), 51 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
