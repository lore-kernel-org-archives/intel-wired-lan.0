From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Wed, 3 Nov 2021 19:41:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next 08/15] iavf: restore MSI
 state on reset
In-Reply-To: <20210604165335.33329-8-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-8-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB5144A3D78C8E6CD5EF69BAF9E28C9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, June 4, 2021 9:53 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 08/15] iavf: restore MSI state on reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the PF experiences an FLR, the VF's MSI and MSI-X configuration will be
> conveniently and silently removed in the process. When this happens, reset
> recovery will appear to complete normally but no traffic will pass. The netdev
> watchdog will helpfully notify everyone of this issue.
> 
> To prevent such public embarrassment, restore MSI configuration at every reset.
> For normal resets, this will do no harm, but for VF resets resulting from a PF FLR,
> this will keep the VF working.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
