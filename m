From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 21:09:04 +0000
Subject: [Intel-wired-lan] [next PATCH S18 4/8] i40evf: use correct
 struct	for list manipulation
In-Reply-To: <1443724661-92168-5-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B37FA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S18 4/8] i40evf: use correct struct for
> list manipulation
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Not sure how this compiles at all. Use the correct struct for manipulating the
> VLAN filter list. Without this, the VLAN filter list doesn't get processed
> correctly, and VLAN filters will not be re-enabled after any kind of reset.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Iceff2dc089f303058fb71ecb08419eed471e0e90
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
