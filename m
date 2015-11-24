From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Nov 2015 23:52:09 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 11/12] i40evf: change
 version	string generation
In-Reply-To: <1447961665-12344-12-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-12-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F892A0F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 11/12] i40evf: change version
> string generation
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Generate version strings like the PF driver does. This gives us more flexibility
> to add suffixes to the version string at build time.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0a5ca0783dd8fb849516bfc1e37ea070127847bd
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver reports correct version info
