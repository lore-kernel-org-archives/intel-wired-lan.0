From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:32:47 +0000
Subject: [Intel-wired-lan] [PATCH 12/19] igc: Fix NFC rules with
 multicast addresses
In-Reply-To: <20200424201623.10971-13-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-13-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890E8C8EA1B7718EDC12BE0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 12/19] igc: Fix NFC rules with multicast
> addresses
> 
> Multicast MAC addresses are valid address for NFC rules but
> igc_add_mac_filter() is currently rejecting them. In fact, the I225
> controller doesn't impose any constraint on the address value so this
> patch gets rid of the address validation check in MAC filter APIs.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
