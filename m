From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 20:16:45 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 12/13] i40e: Input set
 mask	constants for RSS, flow director, and flex bytes
In-Reply-To: <1459508173-22777-13-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-13-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACC30@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 12/13] i40e: Input set mask
> constants for RSS, flow director, and flex bytes
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Defines for input set mask (RSS, flow director, flexible payload).
> Also renames some defines related to RSS and flow-director. This patch adds
> defines specific to IPv6 flex mask needed to support change of RSS hash
> input set for flows such as TCP6 and UDP6.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ie95ef7d0916a4d6ca011c194283f959774c8dce9
> ---
> Testing Hints: This patch applies and compiles cleanly. Preparation patch for
> implementing features such as changing input set mask for RSS, and flow
> director.
> 
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 33
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 42
> +++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code compiles and passes traffic
