From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:44:04 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 2/6] i40e: Add macro for PF
 reset	bit
In-Reply-To: <150478201163.24662.6473874525961508125.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478201163.24662.6473874525961508125.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2B7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Thursday, September 7, 2017 4:00 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [RFC PATCH v3 2/6] i40e: Add macro for PF reset bit
> 
> Introduce a macro for the bit setting the PF reset flag and update its usages.
> This makes it easier to use this flag in functions to be introduced in future
> without encountering checkpatch issues related to alignment and line over
> 80 characters.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |    2 ++
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    3 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |    9 ++++-----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    5 ++---
>  4 files changed, 9 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


