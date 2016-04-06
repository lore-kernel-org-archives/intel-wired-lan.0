From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 22:43:00 +0000
Subject: [Intel-wired-lan] [v4 next PATCH S32 12/13] i40e: Input set
 mask	constants for RSS, flow director, and flex bytes
In-Reply-To: <1459778470-26039-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459778470-26039-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AD051@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Monday, April 04, 2016 7:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v4 next PATCH S32 12/13] i40e: Input set mask
> constants for RSS, flow director, and flex bytes
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add defines for input set mask (RSS, flow director, flexible payload),
> including defines specific to IPv6.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ie95ef7d0916a4d6ca011c194283f959774c8dce9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 33
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 42
> +++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code compiles and passes traffic
