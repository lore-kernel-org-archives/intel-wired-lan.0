From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:11:56 +0000
Subject: [Intel-wired-lan] [PATCH S27 08/15] ice: Update fields in
 ice_vsi_set_num_qs when reconfiguring
In-Reply-To: <20190808143938.4968-8-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-8-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D41165A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 08/15] ice: Update fields in
> ice_vsi_set_num_qs when reconfiguring
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when vsi->req_txqs or vsi->req_rxqs are set we don't correctly set
> the number of vsi->num_q_vectors. Fix this by setting the the number of
> queue vectors based on the max between the vsi->alloc_txqs and vsi-
> >alloc_rxqs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


