From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:15:04 +0000
Subject: [Intel-wired-lan] [PATCH 05/19] igc: Add 'igc_ethtool_' prefix
 to functions in igc_ethtool.c
In-Reply-To: <20200424201623.10971-6-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-6-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289095B0F8D6A188610B91A0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 05/19] igc: Add 'igc_ethtool_' prefix to
> functions in igc_ethtool.c
> 
> This patch adds the prefix 'igc_ethtool_' to all functions defined in
> igc_ethtool.c so they align with the name convention already followed by
> other parts of the driver (e.g. igc_tsn, igc_ptp). Also, this avoids
> some name clashing with functions added to igc_main.c by upcoming
> patches in this series. No functionality is changed by this patch, just
> function renaming.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   3 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 215 ++++++++++---------
>  drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
>  3 files changed, 112 insertions(+), 108 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
