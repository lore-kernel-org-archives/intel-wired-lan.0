From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 21:47:51 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/4] igc: Refactor VLAN priority
 filtering code
In-Reply-To: <20200424011119.98746-1-andre.guedes@intel.com>
References: <20200403181743.23447-5-andre.guedes@intel.com>
 <20200424011119.98746-1-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890E517D65797E6E2CFC206BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Guedes, Andre <andre.guedes@intel.com>
> Sent: Thursday, April 23, 2020 6:11 PM
> To: intel-wired-lan at lists.osuosl.org; Brown, Aaron F
> <aaron.f.brown@intel.com>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: [PATCH v2 4/4] igc: Refactor VLAN priority filtering code
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
> v2: Previous version had a bug when clearing IGC_VLANPQF_QSEL bits in
>     igc_del_vlan_prio_filter().
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  3 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 64 ++++----------------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 52 ++++++++++++++++
>  3 files changed, 68 insertions(+), 51 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

