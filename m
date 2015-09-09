From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 22:32:55 +0000
Subject: [Intel-wired-lan] [next PATCH S13 10/15] i40e: refactor code
	to	remove indent
In-Reply-To: <1440798961-17326-11-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5EE7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 10/15] i40e: refactor code to
> remove indent
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> I found a code indent that was avoidable because a whole function is inside
> an if block, reverse the if and move the code back a tab.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I9989c8750ee61678fbf96a3b0fd7bf7cc7ef300a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 82 +++++++++++++++--------
> ------
>  1 file changed, 42 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
