From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:17:04 +0000
Subject: [Intel-wired-lan] [PATCH S56 12/13] ice: Remove unnecessary
 blank line
In-Reply-To: <20210302181545.51822-12-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-12-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51149A136A47E7D275964E13FA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S56 12/13] ice: Remove unnecessary blank
> line
> 
> Checkpatch reports the following, fix it.
> 
> -----------------------------------------
> drivers/net/ethernet/intel/ice/ice_main.c
> -----------------------------------------
> CHECK:BRACES: Blank lines aren't necessary before a close brace '}'
> FILE: drivers/net/ethernet/intel/ice/ice_main.c:455:
> +
> +}
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


