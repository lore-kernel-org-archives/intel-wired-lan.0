From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 16:40:37 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 15/15] i40evf: avoid an
 extra	msleep while
In-Reply-To: <1475685046-16900-16-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-16-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC1F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 15/15] i40evf: avoid an extra
> msleep while
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Remove the second call to msleep outside the loop, and move the msleep
> within the loop as the first step. This guarantees that a single loop will wait
> the minimum time first, and then after the reset finishes we no longer need
> an extra msleep.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ib2086f0a142402b614f67846bc091754203a0b9a
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


