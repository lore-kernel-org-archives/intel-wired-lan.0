From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:03:22 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40evf: fix compiler warning of
 unused	variable
In-Reply-To: <1443946189-8543-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1443946189-8543-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1DD6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Sunday, October 04, 2015 1:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] i40evf: fix compiler warning of unused
> variable
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Compiler complained of an unused variable, which the driver was just using
> to store the result of a rd32 which is used to clear a register unconditionally.
> Just drop the unused variable and re-use one.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: Fix title since Jesse used the same title for two difference patches
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
 Patch code changes correctly applied, compiler does not issue unused variable warning at compile time.
