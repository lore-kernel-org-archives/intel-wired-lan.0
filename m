From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:38:32 +0000
Subject: [Intel-wired-lan] [next PATCH S5 06/10] i40e: add input
 validation for virtchnl handlers
In-Reply-To: <20190424122055.27896-6-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C6CF@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S5 06/10] i40e: add input validation for
> virtchnl handlers
> 
> From: Sergey Nemov <sergey.nemov@intel.com>
> 
> Change some data to unsigned int instead of integer when we compare.
> 
> Check LUT values in VIRTCHNL_OP_CONFIG_RSS_LUT handler.
> 
> Also enhance error/warning messages to print the real values of
> I40E_MAX_VF_QUEUES, I40E_MAX_VF_VSI and
> I40E_DEFAULT_QUEUES_PER_VF instead of plain text.
> 
> Refactor code to comply with 'check first then assign' policy.
> 
> Remove duplicate checks for VIRTCHNL_OP_CONFIG_RSS_KEY and
> VIRTCHNL_OP_CONFIG_RSS_LUT opcodes in i40e_vc_process_vf_msg(). We
> have the very same checks inside the handlers already.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 74 ++++++++-----------
>  1 file changed, 31 insertions(+), 43 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


