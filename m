From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Mar 2016 18:23:11 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 08/12] i40evf: Fix
 get_rss_aq
In-Reply-To: <1458328696-135941-9-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-9-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EE3C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 08/12] i40evf: Fix get_rss_aq
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> We were passing in the seed where we should just be passing false because
> we want the vsi table not the pf table.
> 
> Testing Hints: Make sure that ethtool -x gives the proper table.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I9b633ab06eb59468087f0c0af8539857e99f9495
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ethtool -x returns correct table when used on VF
