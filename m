From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Feb 2019 21:50:50 +0000
Subject: [Intel-wired-lan] [PATCH S11 03/16] ice: Fix added in VSI
 supported nodes calc
In-Reply-To: <20190208205043.11975-4-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366986@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 03/16] ice: Fix added in VSI supported
> nodes calc
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> VSI supported nodes are calculated in order to add the VSI parent or
> intermediate nodes to the scheduler tree. If one of the node in below layers
> (from VSI layer) has space to add the new VSI or intermediate node above
> that layer then it's not required to continue the calculation further for below
> layers.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


