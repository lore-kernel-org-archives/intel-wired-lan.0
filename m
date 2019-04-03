From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:58:18 +0000
Subject: [Intel-wired-lan] [next PATCH S4 07/11] i40e: add num_vectors
 checker in iwarp handler
In-Reply-To: <20190329220840.51187-7-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3787F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S4 07/11] i40e: add num_vectors
> checker in iwarp handler
> 
> From: Sergey Nemov <sergey.nemov@intel.com>
> 
> Field num_vectors from struct virtchnl_iwarp_qvlist_info should not be
> larger than num_msix_vectors_vf in the hw struct.  The iwarp uses the same
> set of vectors as the LAN VF driver.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


