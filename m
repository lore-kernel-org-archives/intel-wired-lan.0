From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 22:02:46 +0000
Subject: [Intel-wired-lan] [PATCH S59 11/13] ice: downgrade error print
 to debug print
In-Reply-To: <20210506154008.12880-11-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-11-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510508735EC98FA7680E37ADFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S59 11/13] ice: downgrade error print to
> debug print
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Failing to add or remove LLDP filter doesn't seem to be a fatal error, so
> downgrade the dev_err message to a dev_dbg message.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


