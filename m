From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 22:43:08 +0000
Subject: [Intel-wired-lan] [next PATCH S13 12/15] i40e/i40evf: pass
	QOS	handle to VF
In-Reply-To: <1440798961-17326-13-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5F66@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S13 12/15] i40e/i40evf: pass QOS
> handle to VF
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The VF really doesn't care about the QOS handle but it will in the future.
> Since the VF only uses TC0, send it that handle. On the VF side, save the
> handle and use it to populate the QOS params when we call into the client
> interface.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I76f41b070baeaa09b19383e9168bc677837e0761
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++--
>  drivers/net/ethernet/intel/i40evf/i40evf.h         | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
