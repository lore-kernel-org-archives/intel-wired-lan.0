From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:35:03 +0000
Subject: [Intel-wired-lan] [PATCH S18 06/15] ice: Always free/allocate
 q_vectors
In-Reply-To: <20190416172128.27184-7-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3998EC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 06/15] ice: Always free/allocate
> q_vectors
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when probing/removing the driver we allocate/deallocate each vsi-
> >q_vectors array in ice_vsi_alloc_arrays() and
> ice_vsi_free_arrays() respectively. However, we don't do this during the
> reset and VSI rebuild flow. This is inconsistent and unnecessary to have a
> difference between the two flows.
> 
> This patch makes the change to always allocate/deallocate the
> vsi->q_vectors array regardless of the driver flow we are in.
> 
> Also, update the comment for ice_vsi_free_arrays() to be more descriptive.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 34 ++++++++++--------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


