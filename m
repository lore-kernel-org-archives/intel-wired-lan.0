From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 18:58:23 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 05/12] i40evf: check
 rings	before freeing resources
In-Reply-To: <1447961665-12344-6-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-6-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F966BCE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [V3: next PATCH S22 05/12] i40evf: check rings
> before freeing resources
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the driver gets unloaded during reset recovery, it's possible that it will
> attempt to free resources when they're already free.
> 
> Add a check to make sure that the tx and rx rings actually exist before
> dereferencing them to free resources.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I4d2b7e9ede49f634d421a4c5deaa5446bc755eee
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
