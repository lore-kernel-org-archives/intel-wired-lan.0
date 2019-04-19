From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Apr 2019 17:17:17 +0000
Subject: [Intel-wired-lan] [next PATCH] i40e: Fix of memory leak and
 integer truncation in i40e_virtchnl.c
In-Reply-To: <20190416221546.22721-1-alice.michael@intel.com>
References: <20190416221546.22721-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38EE59@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, April 16, 2019 3:16 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Szapar, Martyna <martyna.szapar@intel.com>
> Subject: [Intel-wired-lan] [next PATCH] i40e: Fix of memory leak and integer
> truncation in i40e_virtchnl.c
> 
> From: Martyna Szapar <martyna.szapar@intel.com>
> 
> Fixed possible memory leak in i40e_vc_add_cloud_filter function:
> cfilter is being allocated and in some error conditions the function returns
> without freeing the memory.
> 
> Fix of integer truncation from u16 (type of queue_id value) to u8 when
> calling i40e_vc_isvalid_queue_id function.
> 
> Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


