From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Dec 2015 19:13:37 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S23 12/13] i40e: update
 features	with right offload
In-Reply-To: <1449776331-8330-2-git-send-email-joshua.a.hay@intel.com>
References: <1449776331-8330-1-git-send-email-joshua.a.hay@intel.com>
 <1449776331-8330-2-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F8BF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Thursday, December 10, 2015 11:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S23 12/13] i40e: update features
> with right offload
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Synchronize code bases and add SCTP offload support.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I9f99071f7176225479026930c387bf681a47494e
> ---
> V2: remove reviewed-by
> 
> Testing Hints: Test SCTP in a tunnel like vxlan and make sure TSO is still
> working.  Test GRE tunnels and make sure they work.  See already applied
> GRE upstream commit for instructions.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, GRE tunnels work, SCTP over VxLAN works
