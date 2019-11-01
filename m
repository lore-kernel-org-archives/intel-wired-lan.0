From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:43:16 +0000
Subject: [Intel-wired-lan] [PATCH S32 07/15] ice: Check if VF is
 disabled for Opcode and other operations
In-Reply-To: <20191025143441.50151-7-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-7-anthony.l.nguyen@intel.com>
Message-ID: <827d3dd5b3dd4e16ac6762f6070c1d95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 07/15] ice: Check if VF is disabled for
> Opcode and other operations
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch adds code to check if PF or VF is disabled before honoring mailbox
> message to configure VF - If it is disabled, and opcode is for resetting VF, the
> PF driver simply tell VF that all is set. In addition, if reset is ongoing, and
> Admin intend to configure VF on the host, we can poll the VF enabling bit to
> make sure it is ready before continue - If after ~250 milliseconds, VF is not in
> active state, we can bail out with invalid error.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 74 ++++++++++++++++---
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  1 +
>  2 files changed, 63 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


