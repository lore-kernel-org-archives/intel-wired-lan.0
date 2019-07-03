From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:40:29 +0000
Subject: [Intel-wired-lan] [next PATCH S7 4/9] i40e: don't report link
 up for a VF who hasn't enabled queues
In-Reply-To: <20190702122259.79070-4-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD251@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S7 4/9] i40e: don't report link up for a
> VF who hasn't enabled queues
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit d3d657a90850 ("i40e: update VFs of link state after
> GET_VF_RESOURCES") modified the PF driver to notify a VF of its link status
> immediately after it requests resources.
> 
> This was intended to fix reporting on VF drivers, so that they would properly
> report link status.
> 
> However, some older VF drivers do not respond well to receiving a link up
> notification before queues are enabled. This can cause their state machine to
> think that it is safe to send traffic. This results in a Tx hang on the VF.
> 
> More recent versions of the old i40evf and all versions of iavf are resilient to
> these early link status messages. However, if a VM happens to run an older
> version of the VF driver, this can be problematic.
> 
> Record whether the PF has actually enabled queues for the VF. When
> reporting link status, always report link down if the queues aren't enabled. In
> this way, the VF driver will never receive a link up notification until after its
> queues are enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 13 ++++++++++++-
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


