From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:29:26 +0000
Subject: [Intel-wired-lan] [next PATCH S9 7/7] i40e: use BIT macro to
 specify the cloud filter field flags
In-Reply-To: <20190826181655.15106-7-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-7-alice.michael@intel.com>
Message-ID: <ab7bbdfce25d4060aeeddd4aa7ea5a53@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 7/7] i40e: use BIT macro to specify
> the cloud filter field flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The macros used to specify the cloud filter fields are intended to be
> individual bits. Declare them using the BIT() macro to make their intention a
> little more clear.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


