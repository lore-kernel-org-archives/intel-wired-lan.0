From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 20:44:52 +0000
Subject: [Intel-wired-lan] [next PATCH S19 11/15] i40evf: handle many
 MAC	filters correctly
In-Reply-To: <1445471236-35918-12-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3F33@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 11/15] i40evf: handle many MAC
> filters correctly
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When a lot (many hundreds) of MAC or VLAN filters are added at one time,
> we can overflow the Admin Queue buffer size with all the requests.
> Unfortunately, the driver would then calculate the message size incorrectly,
> causing it to be rejected by the PF. Furthermore, there was no mechanism to
> trigger another request to allow for configuring the rest of the filters that
> didn't fit into the first request.
> 
> To fix this, recalculate the correct buffer size when we detect the overflow
> condition instead of just assuming the max buffer size. Also, don't clear the
> request bit in adapter->aq_required when we have an overflow, so that the
> rest of the filters can be processed later.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Idd7cbbc5af31315e0dcb1b10e6a02ad9817ce65c
> 
> ---
> Testing-hints: 5645131, 5645133
> Bring up a VF and add 2000 IPv6 addresses to it. Before this patch, it will
> crash. After this patch, it will crash less horribly.
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 32 ++++++++++++++++---
> ---
>  1 file changed, 24 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, system still crashes but does not lock up system. Still have to reboot, however.
