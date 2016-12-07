From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 7 Dec 2016 21:16:05 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Reduce I2C retry count on
 X550	devices
In-Reply-To: <1478800649-22831-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1478800649-22831-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39806@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, November 10, 2016 9:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Reduce I2C retry count on X550
> devices
> 
> A retry count of 10 is likely to run into problems on X550 devices that have to
> detect and reset unresponsive CS4227 devices. So, reduce the I2C retry
> count to 3 for X550 and above. This should avoid any possible regressions in
> existing devices.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> 
> v2 -
>   Removed mac check in ixgbe_read_i2c_combined_generic_int(); set initial
>   max_retry value to 3 instead.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


