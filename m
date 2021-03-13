From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:16:02 +0000
Subject: [Intel-wired-lan] [PATCH S56 11/13] ice: Correct comment block
 style
In-Reply-To: <20210302181545.51822-11-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-11-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB51143B21EB01C1A7457674E6FA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S56 11/13] ice: Correct comment block style
> 
> The following is reported by checkpatch, correct it.
> 
> -----------------------------------------------
> drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> -----------------------------------------------
> WARNING:NETWORKING_BLOCK_COMMENT_STYLE: networking block
> comments don't use an empty /* line, use /* Comment...
> FILE: drivers/net/ethernet/intel/ice/ice_adminq_cmd.h:1428:
> +/*
> + * Send to PF command (indirect 0x0801) ID is only used by PF
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


