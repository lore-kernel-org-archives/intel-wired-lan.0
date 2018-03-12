From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 21:09:02 +0000
Subject: [Intel-wired-lan] [S87 v5 3/7] i40e: Fix permission check for
 VF MAC filters
In-Reply-To: <20180308225211.12254-3-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BE1C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [S87 v5 3/7] i40e: Fix permission check for VF MAC
> filters
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> When VF requests adding of MAC filters the checking is done against number
> of already present MAC filters not adding them at the same time. It makes it
> possible to add a bunch of filters at once possibly exceeding acceptable limit
> of I40E_VC_MAX_MAC_ADDR_PER_VF filters.
> 
> This happens because when checking vf->num_mac, we do not check how
> many filters are being requested at once. Modify the check function to
> ensure that it knows how many filters are being requested. This allows the
> check to ensure that the total number of filters in a single request does not
> cause us to go over the limit.
> 
> Additionally, move the check to within the lock to ensure that the
> vf->num_mac is checked while holding the lock to maintain consistency.
> We could have simply moved the call to i40e_vf_check_permission to within
> the loop, but this could cause a request to be non-atomic, and add some but
> not all the addresses, while reporting an error code. We want to avoid this
> behavior so that users are not confused about which filters have or have not
> been added.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 79 ++++++++++++++---
> -----
>  1 file changed, 51 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


