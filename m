From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 20:00:34 +0000
Subject: [Intel-wired-lan] [next PATCH S17 01/11] i40evf: don't give up
In-Reply-To: <1443464220-148318-2-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2D2E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 01/11] i40evf: don't give up
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When the VF driver is unable to communicate with the PF, it just gives up and
> never tries again. Aside from the obvious character flaw that this shows, it's
> also a lousy user experience.
> 
> When PF communications fail, wait five seconds, and try again. And again.
> Don't give up, little VF driver! Your prince will come!
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ia1378a39879883563b8faffce819f375821f9585
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
