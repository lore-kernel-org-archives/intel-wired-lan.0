From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 21:29:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: separate PF and VSI state flags
In-Reply-To: <20170421203805.11445-2-jacob.e.keller@intel.com>
References: <20170421203805.11445-1-jacob.e.keller@intel.com>
 <20170421203805.11445-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1387@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, April 21, 2017 1:38 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] i40e: separate PF and VSI state flags
> 
> Avoid using the same named flags for both vsi->state and pf->state. This
> makes code review easier, as it is more likely that future authors will use the
> correct state field when checking bits. Previous commits already found issues
> with at least one check, and possibly others may be incorrect.
> 
> This reduces confusion as it is more clear what each flag represents, and
> which flags are valid for which state field.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> This version has the fixup! already squashed in for convenience. Again it
> replaces the patch with the same title on the queue.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h          | 12 ++++-
>  drivers/net/ethernet/intel/i40e/i40e_client.c   |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c  |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 66 ++++++++++++-----------
> --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |  8 +--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |  8 +--
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  7 ++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 ++--
>  8 files changed, 64 insertions(+), 55 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Confirmed fixes earlier regression
