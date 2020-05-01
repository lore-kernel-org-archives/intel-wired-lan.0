From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:26:25 +0000
Subject: [Intel-wired-lan] [PATCH 09/19] igc: Fix 'sw_idx' type in
 struct igc_nfc_rule
In-Reply-To: <20200424201623.10971-10-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-10-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28909E582AEF871EC5210DA0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 09/19] igc: Fix 'sw_idx' type in struct
> igc_nfc_rule
> 
> The 'sw_idx' field from 'struct igc_nfc_rule' is u16 type but it is
> assigned an u32 value in igc_ethtool_init_nfc_rule(). This patch changes
> 'sw_idx' type to u32 so they match. Also, it makes more sense to call
> this field 'location' since it holds the NFC rule location.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
