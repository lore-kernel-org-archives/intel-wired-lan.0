From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:21:02 +0000
Subject: [Intel-wired-lan] [PATCH 07/19] igc: Change byte order in
 struct igc_nfc_filter
In-Reply-To: <20200424201623.10971-8-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-8-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890A921B4AE39FA0BBE64A0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 07/19] igc: Change byte order in struct
> igc_nfc_filter
> 
> Every time we access the 'etype' and 'vlan_tci' fields from struct
> igc_nfc_filter to enable or disable filters in hardware we have to
> convert them from big endian to host order so it makes more sense to
> simply have these fields in host order.
> 
> The byte order conversion should take place in igc_ethtool_get_nfc_
> rule() and igc_ethtool_add_nfc_rule(), which are called by .get_rxnfc
> and .set_rxnfc ethtool ops, since ethtool subsystem is the one who deals
> with them in big endian order.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 10 ++------
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 25 +++++++++-----------
>  2 files changed, 13 insertions(+), 22 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
