From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:55:42 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 11/13] i40evf: Add
 additional	check for reset
In-Reply-To: <1457650791-100229-12-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-12-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D382@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of ajdayana
> Sent: Thursday, March 10, 2016 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S30 v3 11/13] i40evf: Add additional
> check for reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the driver happens to read a register during the time in which the device is
> undergoing reset, it will receive a value of 0xdeadbeef instead of a valid
> value. Unfortunately, the driver may misinterpret this as a valid value,
> especially if it's just looking for individual bits.
> 
> Add an explicit check for this value when we are looking for admin queue
> errors, and trigger reset recovery if we find it.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly handles commands while device is in reset, confirmed registers return 0xDEADBEEF during reset
