From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Sep 2015 17:30:02 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a memory leak in X722
	rss	config path
In-Reply-To: <1440448013-196583-1-git-send-email-anjali.singhai@intel.com>
References: <1440448013-196583-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5A38@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Monday, August 24, 2015 1:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix a memory leak in X722 rss config
> path
> 
> In any case free the memory allocated before exiting.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code present in tree, does not break base driver.
