From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 00:50:25 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 12/13] i40e: disallow
 programming multiple filters with same criteria
In-Reply-To: <20171227132532.24219-1-alice.michael@intel.com>
References: <20171227132532.24219-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7141@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 12/13] i40e: disallow
> programming multiple filters with same criteria
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Our hardware does not allow situations where two filters might conflict when
> matching. Essentially hardware only programs one filter for each set of
> matching criteria. We don't support filters with overlapping input sets,
> because each flow type can only use a single input set.
> 
> Additionally, different flow types will never have overlapping matches,
> because of how the hardware parses the flow type before checking
> matching criteria.
> 
> For this reason, we do not need or use the location number when
> programming filters to hardware.
> 
> In order to avoid confusing scenarios with filters that match the same criteria
> but program the flow to different queues, do not allow multiple filters that
> match identical criteria to be programmed.
> 
> This ensures that we avoid odd scenarios when deleting filters, and when
> programming new filters that match the same criteria.
> 
> Instead, users that wish to update the criteria for a filter must use the same
> location id, or must delete all the matching filters first.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 87
> ++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


