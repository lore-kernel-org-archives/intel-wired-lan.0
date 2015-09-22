From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Sep 2015 21:30:08 +0000
Subject: [Intel-wired-lan] [next-queue v2 6/8] i40e: declare rather
	than	initialize int object
In-Reply-To: <1442660927-30431-6-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
 <1442660927-30431-6-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1753@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Saturday, September 19, 2015 4:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2 6/8] i40e: declare rather than
> initialize int object
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> 'err' would be overwritten immediately, so we should declare it only rather
> than initialize it to zero.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
