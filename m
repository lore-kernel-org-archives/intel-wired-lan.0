From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 21:49:24 +0000
Subject: [Intel-wired-lan] [next PATCH S11 01/15] i40e: Increase the
 amount	of time we wait for reset to be done
In-Reply-To: <1440616461-110869-2-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A58D5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M
> Subject: [Intel-wired-lan] [next PATCH S11 01/15] i40e: Increase the amount
> of time we wait for reset to be done
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> In some rare cases the reset can take longer to complete so increase the
> amount of time we wait.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Change-ID: Ib5628ec54b526a811ee33d1214fe763226406671
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
