From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 2 May 2022 08:19:28 +0000
Subject: [Intel-wired-lan] [PATCH v4 intel-next 1/3] ice: remove u16
 arithmetic in ice_gnss
In-Reply-To: <20220429102145.74764-1-karol.kolacinski@intel.com>
References: <20220429102145.74764-1-karol.kolacinski@intel.com>
Message-ID: <BYAPR11MB33675756A56DBC428E95B688FCC19@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karol Kolacinski
> Sent: Friday, April 29, 2022 3:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kolacinski, Karol <karol.kolacinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 intel-next 1/3] ice: remove u16
> arithmetic in ice_gnss
> 
> Change u16 to u32 where arithmetic occurres.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V3 -> V4: Add one missed line
> V2 -> V3: Add previously removed err variable
> V1 -> V2: Use more native types
> 
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
