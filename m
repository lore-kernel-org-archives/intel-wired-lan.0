From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 12 Oct 2017 17:13:29 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2 net-next] i40e/i40evf: don't
 trust	VF to reset itself
In-Reply-To: <20171011214943.7076-2-alan.brady@intel.com>
References: <20171011214943.7076-1-alan.brady@intel.com>
 <20171011214943.7076-2-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC72B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Wednesday, October 11, 2017 2:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/2 net-next] i40e/i40evf: don't trust VF
> to reset itself
> 
> When using 'ethtool -L' on a VF to change number of requested queues from
> PF, we shouldn't trust the VF to reset itself after making the request.  Doing
> it that way opens the door for a potentially malicious VF to do nasty things to
> the PF which should never be the case.
> 
> This makes it such that after VF makes a successful request, PF will then reset
> the VF to institute required changes.  Only if the request fails will PF send a
> message back to VF letting it know the request was unsuccessful.
> 
> Testing-hints:
> There should be no real functional changes.  This is simply hardening against a
> potentially malicious VF.
> 
> v2: remove extra commit tags
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 9 +++++++--
> drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 7 +++----
>  include/linux/avf/virtchnl.h                        | 4 ++--
>  3 files changed, 12 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


