From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:56:05 +0000
Subject: [Intel-wired-lan] [next PATCH S8 01/12] i40e: fix shifts of
 signed values
In-Reply-To: <20190723100144.57435-1-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CF26@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Xing, Beilei <beilei.xing@intel.com>; Yigit, Ferruh
> <ferruh.yigit@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 01/12] i40e: fix shifts of signed
> values
> 
> From: Beilei Xing <beilei.xing@intel.com>
> 
> This patch fixes following error reported by cppcheck:
> (error) Shifting signed 32-bit value by 31 bits is undefined behaviour
> 
> Signed-off-by: Ferruh Yigit <ferruh.yigit@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_register.h   | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


