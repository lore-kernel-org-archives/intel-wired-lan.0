From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 22:12:33 +0000
Subject: [Intel-wired-lan] [next PATCH S18 2/8] i40e: fix a bug in
 debugfs	with add/del macaddr
In-Reply-To: <1443724661-92168-3-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B386E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S18 2/8] i40e: fix a bug in debugfs with
> add/del macaddr
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The new code flow requires us to grab the filter list lock before
> adding/deleting the filter.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I4eaef508ab4da2d1b2e23f20f2a78d931d5b6aeb
> 
> ---
> Testing-hints: 5645669
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver no longer crashes when adding/removing MAC addresses via admin queue/debugfs commands.
