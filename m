From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Aug 2015 15:31:56 +0000
Subject: [Intel-wired-lan] [net-next PATCH 1/2] i40e: fix kbuild warnings
In-Reply-To: <20150814015426.3815.89257.stgit@jbrandeb-hsm1.jf.intel.com>
References: <20150814015426.3815.89257.stgit@jbrandeb-hsm1.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016CB4FE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, August 13, 2015 6:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH 1/2] i40e: fix kbuild warnings
> 
> The 0day build infrastructure found some issues in i40e, this removes the
> warnings by adding a harmless cast to a dev_info.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> CC: kbuild-all at 01.org
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

In git log, code changes present in tree, no kbuild warnings from i40e code when building kernel.
