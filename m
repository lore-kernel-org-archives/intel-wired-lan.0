From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 21:51:52 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 2/9] i40e: Drop packet
 split	receive routine
In-Reply-To: <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D234D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 2/9] i40e: Drop packet split
> receive routine
> 
> As part of preparation for the rx-refactor, remove the packet split receive
> routine and ancillary code.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   3 -
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  19 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  49 +----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 245 +------------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   7 -
>  6 files changed, 10 insertions(+), 317 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
PAcket split options no longer present or reported
