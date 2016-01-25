From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Jan 2016 22:21:56 +0000
Subject: [Intel-wired-lan] [next PATCH S28 14/15] i40e: When in promisc
 mode	apply promisc mode to Tx Traffic as well
In-Reply-To: <1452897202-15204-15-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-15-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C4C9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 14/15] i40e: When in promisc
> mode apply promisc mode to Tx Traffic as well
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> In MFP mode particularly when we were setting the PF VSI in limited
> promiscuous, the HW switch was still mirroring the outgoing packets from
> other VSIs (VF/VMdq) onto the PF VSI.
> 
> With this new bit set, the mirroring doesn't happen any more and so we are
> in limited promiscuous on the PF VSI in MFP which is similar to defport.
> 
> An API check is not required, since this bit is reserved for FW API version <
> 1.5
> 
> Also update copyright year in file headers.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I9840cb95f11dde733d943cb03ce84f68b9611bc8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c       | 9 ++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 3 ++-
>  3 files changed, 12 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no mirroring of VF traffic in PF observed.
