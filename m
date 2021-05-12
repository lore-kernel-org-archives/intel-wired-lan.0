From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 21:56:50 +0000
Subject: [Intel-wired-lan] [PATCH S59 05/13] ice: (re)initialize NVM
 fields when rebuilding
In-Reply-To: <20210506154008.12880-5-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51054D67DF3DF58DAD7DADBEFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 05/13] ice: (re)initialize NVM fields
> when rebuilding
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> After performing a flash update, a device EMP reset may occur. This reset will
> cause the newly downloaded firmware to be initialized. When this happens,
> the driver still reports the previous NVM version information.
> 
> This is because the NVM versions are cached within the hw structure.
> This can be confusing, as the new firmware is in fact running in this case.
> 
> Handle this by calling ice_init_nvm when rebuilding the driver state.
> This will update the flash version information and ensures that the current
> values are displayed when reporting the NVM versions to the stack.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


 

