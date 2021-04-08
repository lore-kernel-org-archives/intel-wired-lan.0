From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 22:26:37 +0000
Subject: [Intel-wired-lan] [PATCH S58 10/13] ice: suppress false
 cppcheck issues
In-Reply-To: <20210331211708.55205-10-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-10-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51051EA5D370F1C8E30BE57AFA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 10/13] ice: suppress false cppcheck
> issues
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Silence false errors, warnings and style issues reported by cppcheck.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 3 +++
>  drivers/net/ethernet/intel/ice/ice_nvm.c       | 1 +
>  drivers/net/ethernet/intel/ice/ice_sched.c     | 1 +
>  3 files changed, 5 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


