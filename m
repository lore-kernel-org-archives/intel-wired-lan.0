From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:12:10 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 02/14] i40e/i40evf: Record
 ITR register location in the q_vector
In-Reply-To: <20171229134853.14186-1-alice.michael@intel.com>
References: <20171229134853.14186-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D71D5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:49 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 02/14] i40e/i40evf: Record ITR
> register location in the q_vector
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The drivers for i40e and i40evf had a reg_idx value stored in the q_vector
> that was going completely unused. I can only assume this was copied over
> from ixgbe and nobody knew how to use it.
> 
> I'm going to make use of the value to avoid having to compute the vector and
> thus the register index for multiple paths throughout the drivers.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 12 ++++--------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 12 ++++--------
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  4 ++--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  1 +
>  5 files changed, 12 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


