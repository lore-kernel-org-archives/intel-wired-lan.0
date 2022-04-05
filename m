From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 5 Apr 2022 04:50:01 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: use min_t() to make code
 cleaner in ice_gnss
In-Reply-To: <20220321135947.378250-1-wanjiabing@vivo.com>
References: <20220321135947.378250-1-wanjiabing@vivo.com>
Message-ID: <BYAPR11MB33676930AB96198D69C234B0FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wan Jiabing <wanjiabing@vivo.com>
> Sent: Monday, March 21, 2022 7:30 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Wan Jiabing
> <wanjiabing@vivo.com>
> Subject: [PATCH v2] ice: use min_t() to make code cleaner in ice_gnss
> 
> Fix the following coccicheck warning:
> ./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity
> for min()
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v2:
> - Use typeof(bytes_left) instead of u8.
> ---
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
