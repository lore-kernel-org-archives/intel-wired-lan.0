From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 13 Jun 2019 21:33:33 +0000
Subject: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
 struct_size() in kzalloc()
In-Reply-To: <20190605154052.GA7571@embeddedor>
References: <20190605154052.GA7571@embeddedor>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3ED69F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, June 5, 2019 8:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
> struct_size() in kzalloc()
> 
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct virtchnl_iwarp_qvlist_info {
> 	...
>         struct virtchnl_iwarp_qv_info qv_info[1]; };
> 
> size = sizeof(struct virtchnl_iwarp_qvlist_info) + (sizeof(struct
> virtchnl_iwarp_qv_info) * count; instance = kzalloc(size, GFP_KERNEL);
> 
> and
> 
> struct virtchnl_vf_resource {
> 	...
>         struct virtchnl_vsi_resource vsi_res[1]; };
> 
> size = sizeof(struct virtchnl_vf_resource) + sizeof(struct
> virtchnl_vsi_resource) * count; instance = kzalloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, qv_info, count), GFP_KERNEL);
> 
> and
> 
> instance = kzalloc(struct_size(instance, vsi_res, count), GFP_KERNEL);
> 
> Notice that, in the first case above, variable size is not necessary, hence it is
> removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c    | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


