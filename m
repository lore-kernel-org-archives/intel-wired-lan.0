From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Dec 2015 16:46:09 +0000
Subject: [Intel-wired-lan] [net-next v2] i40e: Fix i40e_print_features()
 VEB	mode output
In-Reply-To: <1449145257-110262-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1449145257-110262-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96CB9F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, December 03, 2015 4:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Joe Perches <joe@perches.com>; netdev at vger.kernel.org;
> sergei.shtylyov at cogentembedded.com
> Subject: [Intel-wired-lan] [net-next v2] i40e: Fix i40e_print_features() VEB
> mode output
> 
> From: Joe Perches <joe@perches.com>
> 
> Commit 7fd89545f337 ("i40e: remove BUG_ON from feature string building")
> added defective output when I40E_FLAG_VEB_MODE_ENABLED was set in
> function i40e_print_features.
> 
> Fix it.
> 
> Miscellanea:
> 
> - Remove unnecessary string variable
> - Add space before not after fixed strings
> - Use kmalloc not kzalloc
> - Don't initialize i to 0, use result of first snprintf
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> v2: fixed patch conflicts when trying to apply to my next-queue tree
>     (dev-queue branch), also fixed "Noticed-by" to the more acceptable
>     "Reported-by"
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 42 +++++++++++++------------
> ----
>  1 file changed, 19 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, features correctly print on driver init.
