From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 18:52:52 +0000
Subject: [Intel-wired-lan] [next PATCH v2 2/2] i40evf: fix compiler
 warning of unused variable
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3143@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Wednesday, September 16, 2015 7:01 PM
> To: e1000-patches at isotope.jf.intel.com
> Subject: [Intel-wired-lan] [next PATCH v2 2/2] i40evf: fix compiler warning of unused variable
> 
> Compiler complained of an unused variable, which the driver was just using
> to store the result of a rd32 which is used to clear a register unconditionally.
> Just drop the unused variable and re-use one.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, compiler does not issue unused variable warning at compile time.

