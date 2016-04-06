From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 22:41:06 +0000
Subject: [Intel-wired-lan] [next PATCH v2] i40evf: properly handle
	VLAN	features
In-Reply-To: <1459542871-39856-1-git-send-email-mitch.a.williams@intel.com>
References: <1459542871-39856-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AD040@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Friday, April 01, 2016 1:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH v2] i40evf: properly handle VLAN
> features
> 
> Correctly set the VLAN feature flags after setting the rest of the netdev flags.
> And don't set them in hw_features, because these can't be controlled by the
> VF driver.
> 
> Testing Hints: Make sure VLAN offloads work correctly when not using port
> VLANs, and make sure they're not available when using port VLANs.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 31 +++++++++++++-------
> -----
>  1 file changed, 16 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VLAN offload works as expected on expected interfaces
