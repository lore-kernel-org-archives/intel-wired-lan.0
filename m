From: Switzer, David <david.switzer@intel.com>
Date: Fri, 9 Apr 2021 17:57:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] i40e: clean up packet
 type lookup table
In-Reply-To: <20210223234707.1170711-3-jesse.brandeburg@intel.com>
References: <20210223234707.1170711-1-jesse.brandeburg@intel.com>
 <20210223234707.1170711-3-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB4748F2AC97D38923EDC08F14EB739@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Brandeburg, Jesse
>Sent: Tuesday, February 23, 2021 3:47 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] i40e: clean up packet type
>lookup table
>
>Remove the unused ptype struct value, which makes table init easier for the zero
>entries, and use ranged initializer to remove a bunch of code (works with gcc and
>clang). There is no significant functional change.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>NOTE: this patch generates an expected checkpatch error due to the tricky
>structure initializer macro.
>---
> drivers/net/ethernet/intel/i40e/i40e_common.c | 124 +-----------------
> drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 -
> 2 files changed, 6 insertions(+), 119 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

