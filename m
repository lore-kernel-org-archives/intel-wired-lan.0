From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 19:38:18 +0000
Subject: [Intel-wired-lan] [next PATCH S55 06/14] i40e: add interrupt
 rate	limit verbosity
In-Reply-To: <1480377971-23412-7-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38F2A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S55 06/14] i40e: add interrupt rate
> limit verbosity
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Due to the resolution of the register controlling interrupt rate limiting, setting
> certain values for the interrupt rate limit make it appear as though the
> limiting is not completely accurate.  The problem is that the interrupt rate
> limit is getting rounded down to the nearest multiple of 4.  This patch fixes
> the problem by adding some feedback to the user as to the actual interrupt
> rate limit being used when it differs from the requested limit.  Without this
> patch setting interrupt rate limits may appear to behave inaccurately.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I3093cf3f2d437d35a4c4f4bb5af5ce1b85ab21b7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


