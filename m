From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 19:47:07 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 09/12] i40e/i40evf: Add a
 new	offload for RSS PCTYPE V2 for X722
In-Reply-To: <1447961665-12344-10-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-10-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F966C0F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 09/12] i40e/i40evf: Add a new
> offload for RSS PCTYPE V2 for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 supports Expanded version of TCP, UDP PCTYPES for RSS.
> Add a Virtchnl offload to support this.
> 
> Without this patch with X722 devices, driver will set wrong PCTYPES for VF
> and UDP flows will not fan out.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I04fe4988253b7cd108c9179a643c969764efcb76
> ---
> Testing-Hints:
> Try multiple UDP flows on VF driver to see they get spread out by RSS.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, VF on X722, incoming UDP flows fan out properly.
