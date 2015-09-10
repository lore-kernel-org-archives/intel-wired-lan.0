From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 20:39:43 +0000
Subject: [Intel-wired-lan] [next PATCH S14 11/15] i40evf: don't blow
 away	MAC address
In-Reply-To: <1441065295-234333-12-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A625B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 11/15] i40evf: don't blow away
> MAC address
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Under certain circumstances, we can get an extra VF_RESOURCES message
> from the PF driver at runtime. When this happens, we need to parse it
> because our VSI may have changed out from underneath us, and that will
> affect our relationship with the PF driver.
> 
> However, parsing the resources message also blows away our current MAC
> address in the hardware struct, usually with all zeros. When this happens, the
> next time the interface is opened, it will have no MAC address and will a) not
> work and b) complain.
> 
> Fix this issue by restoring the current MAC address from the netdev struct
> after we parse the resource message.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I6cd1b624fc20432f81dc901166c8de195b8e0e65
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
