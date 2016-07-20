From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 21:11:10 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] ixgbevf: Add range checking
 for	setting MTU
In-Reply-To: <1468431196-23915-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1468431196-23915-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF53@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, July 13, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2] ixgbevf: Add range checking for
> setting MTU
> 
> From: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
> 
> Currently when setting the VF's MTU, the PF can return a NACK but this isn't
> passed on to the VF.  Propagate the results from the PF to the VF so errors
> can be reported.
> 
> In ixgbevf_change_mtu, return an error and reject the change.
> 
> For ixgbevf_configure_rx, log the error for debugging purposes since the
> function is buried in a series of Rx config routines that are void.
> 
> v2:
>   Fixed a typo
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 17 ++++++---
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 42 +++++++++++++++--------
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |  2 +-
>  3 files changed, 40 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
