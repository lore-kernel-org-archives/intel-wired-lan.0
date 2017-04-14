From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Apr 2017 21:47:28 +0000
Subject: [Intel-wired-lan] [next PATCH S70 04/12] i40e: factor out
	queue	control from i40e_vsi_control_(tx|rx)
In-Reply-To: <20170413084555.6962-4-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B9F1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 04/12] i40e: factor out queue
> control from i40e_vsi_control_(tx|rx)
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch will need to be able to handle controlling queues without
> waiting until all VSIs are handled. Factor out the direct queue modification so
> that we can easily re-use this code. The result is also a bit easier to read since
> we don't embed multiple single-letter loop counters.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Id923cbfa43127b1c24d8ed4f809b1012c736d9ac
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 139 ++++++++++++++++++--
> --------
>  1 file changed, 89 insertions(+), 50 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


