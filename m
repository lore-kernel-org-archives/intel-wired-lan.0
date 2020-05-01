From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:12:15 +0000
Subject: [Intel-wired-lan] [PATCH 04/19] igc: Early return in
 igc_get_ethtool_nfc_entry()
In-Reply-To: <20200424201623.10971-5-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-5-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890CF29579355F3F90320A1BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 04/19] igc: Early return in
> igc_get_ethtool_nfc_entry()
> 
> This patch re-writes the second half of igc_ethtool_get_nfc_entry() to
> follow the 'return early' pattern seen in other parts of the driver and
> removes some duplicate comments.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 58 ++++++++++----------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
