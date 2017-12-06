From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Dec 2017 18:24:08 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: Fix kernel-doc format
 warnings
In-Reply-To: <20171204192831.18344-2-anthony.l.nguyen@intel.com>
References: <20171204192831.18344-1-anthony.l.nguyen@intel.com>
 <20171204192831.18344-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EB0978@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, December 4, 2017 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: Fix kernel-doc format
> warnings
> 
> Recent checks added for formatting kernel-doc comments are causing
> warnings if W= is run with a non-zero value.  This patch fixes function
> comments to resolve warnings when W=1 is used.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  6 +++---
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 17 +++++++++++++++--
>  2 files changed, 18 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


