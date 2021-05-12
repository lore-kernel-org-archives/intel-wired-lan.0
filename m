From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 22:05:20 +0000
Subject: [Intel-wired-lan] [PATCH S59 13/13] ice: remove local variable
In-Reply-To: <20210506154008.12880-13-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-13-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105273129C9D75DBD14D09BFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S59 13/13] ice: remove local variable
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> Remove the local variable since it's only used once. Instead, use it directly.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


