From: Young, James M <james.m.young@intel.com>
Date: Tue, 5 May 2015 16:15:20 +0000
Subject: [Intel-wired-lan] [net-next S4 08/15] i40e: fix unrecognized
 FCOE	EOF case
In-Reply-To: <1429229172-143692-9-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F8F3B@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S4 08/15] i40e: fix unrecognized FCOE
> EOF case
> 
> From: Vasu Dev <vasu.dev@intel.com>
> 
> Because i40e_fcoe_ctxt_eof should never be called without
> i40e_fcoe_eof_is_supported being called first, the EOF in fcoe_ctxt_eof
> should always be valid and therefore we do not need to print an error if it is
> not valid.
> 
> However, a WARN ON to easily catch any calls to i40e_fcoe_ctxt_eof that
> aren't preceded with a call to i40e_fcoe_eof_is_supported is helpful.
> 
> Signed-off-by: Vasu Dev <vasu.dev@intel.com>
> Change-ID: I3b536b1981ec0bce80576a74440b7dea3908bdb9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>
	No FCOE feature tested by my, base driver only, this patch does not affect base driver function. 

