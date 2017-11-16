From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:24:32 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 8/9] i40evf: fix client
 notify of l2 params
In-Reply-To: <20171114120052.86665-8-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEEF0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S82-V4 8/9] i40evf: fix client notify of
> l2 params
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> The current method for notifying clients of l2 parameters is broken because
> we fail to copy the new parameters to the client instance struct, we need to
> do the notification before the client 'open' function pointer gets called, and
> lastly we should set the l2 parameters when first adding a client instance.
> 
> This patch first introduces the i40evf_client_get_params function to prevent
> code duplication in the i40evf_client_add_instance and the
> i40evf_notify_client_l2_params functions.  We then fix the notify l2 params
> function to actually copy the parameters to client instance struct and do the
> same in the *_add_instance' function.  Lastly this patch reorganizes the
> priority in which client tasks fire so that if the flag for notifying l2 params is
> set, it will trigger before the open because the client needs these new
> parameters as part of a client open task.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_client.c | 38 ++++++++++++++++-
> ------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c   | 10 +++---
>  2 files changed, 31 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


