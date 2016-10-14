From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 16:40:17 +0000
Subject: [Intel-wired-lan] [next PATCH S50 4/6] i40e: Fix for division
 by	zero
In-Reply-To: <1476224818-16844-5-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA11400@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S50 4/6] i40e: Fix for division by zero
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> For some cases when reading from device are incorrect or image is incorrect,
> this part of code causes crash due to division by zero.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Change-ID: I8961029a7a87b0a479995823ef8fcbf6471405e1
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


