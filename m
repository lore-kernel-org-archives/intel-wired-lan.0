From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 20:14:25 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 10/13] i40e: Add
	RSS	configuration to virtual channel
In-Reply-To: <1459508173-22777-11-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-11-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACC1F@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 10/13] i40e: Add RSS
> configuration to virtual channel
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Add opcodes and structures to support RSS configuration by PF driver on
> behalf of the VF drivers. This reduces complexity in the VF driver and allows
> us to support future hardware designs without modifying the VF driver.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I8c75765c630eacb71f95967f1109a198542593ac
> ---
> Testing Hints : Compile code and make sure there are no warnings. There's
> no actual code here.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 45
> +++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 45
> +++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code compiles and passes traffic
