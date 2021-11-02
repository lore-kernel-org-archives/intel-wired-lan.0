From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:04:52 +0000
Subject: [Intel-wired-lan] [PATCH] ice: rearm other interrupt cause
 register after enabling VFs
In-Reply-To: <20210712115425.214965-1-paul.greenwalt@intel.com>
References: <20210712115425.214965-1-paul.greenwalt@intel.com>
Message-ID: <MN2PR11MB42248B75C4E6B6C96482AEDE828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Greenwalt, Paul
> Sent: Monday, July 12, 2021 4:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: rearm other interrupt cause register
> after enabling VFs
> 
> The other interrupt cause register (OICR), global interrupt 0, is disabled when
> enabling VFs to prevent handling VFLR. If the OICR is not rearmed then the
> VF cannot communicate with the PF.
> 
> Rearm the OICR after enabling VFs.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


