From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:55:13 +0000
Subject: [Intel-wired-lan] [PATCH S22 10/16] ice: Update number of VF
 queue before setting VSI resources
In-Reply-To: <20190626092027.52845-10-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-10-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE48@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 10/16] ice: Update number of VF
> queue before setting VSI resources
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> In case there is a request from a VF to change its number of queues, and the
> request was successful, we need to update number of queues configured on
> the VF before updating corresponding VSI for that VF, especially LAN Tx
> queue tree and TC update, otherwise, we would continued to use old value
> of vf->num_vf_qs for allocated Tx/Rx queues...
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


