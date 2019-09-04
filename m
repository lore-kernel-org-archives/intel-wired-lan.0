From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:27:46 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 8/9] ice: change default number
 of receive descriptors
In-Reply-To: <20190903083108.19593-8-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
 <20190903083108.19593-8-anthony.l.nguyen@intel.com>
Message-ID: <2932e13a713f4f4db4524049ac118033@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 8/9] ice: change default number of
> receive descriptors
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver should start out with a reasonable number of descriptors that can
> prevent drops due to a CPU being in a power management state.
> Change the default number of descriptors to 2048.
> The user can always change the value at runtime.  Transmit descriptor counts
> are not modified because they don't need to change due to the speed of the
> interface, or for power managed CPUs, but the code is simplified to a fixed
> value for the transmit default.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


