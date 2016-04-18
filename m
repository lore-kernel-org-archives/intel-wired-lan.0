From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 21:21:06 +0000
Subject: [Intel-wired-lan] [next PATCH S34 01/12] i40e: Change the
 default	for VFs to be not privileged
In-Reply-To: <1460542112-20166-2-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-2-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D202E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 01/12] i40e: Change the default
> for VFs to be not privileged
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Make sure a VF is not trusted/privileged until its explicitly set for trust
> through the new NDO op interface.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I476385c290d2b4901d8fceb29de43546accdc499
> ---
> Testing Hints (Required if no HSD):
> With this now a VF cannot add filters or enable promisc unless trusted.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 20 ++++++++++---------
> -
>  1 file changed, 10 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF not trusted until implicitly set as trusted
