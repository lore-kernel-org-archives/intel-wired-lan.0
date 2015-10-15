From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:00:50 +0000
Subject: [Intel-wired-lan] [next PATCH S18 1/8] i40e/i40evf: Add
	a	workaround to drop all flow control frames
In-Reply-To: <1443724661-92168-2-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1DB5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S18 1/8] i40e/i40evf: Add a
> workaround to drop all flow control frames
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds a workaround to drop any flow control frames from being
> transmitted from any VSI. FW can still send flow control frames if flow control
> is enabled.
> 
> With this patch in place a malicious VF cannot send flow control or PFC
> packets out on the wire.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I4303b24e98b93066d2767fec24dfe78be591c277
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 22
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 18
> ++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  2 ++
>  4 files changed, 44 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
