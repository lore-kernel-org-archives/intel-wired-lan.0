From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:23:48 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Be more
 careful when modifying MAC filters
In-Reply-To: <20180618160028.80602.76507.stgit@ahduyck-green-test.jf.intel.com>
References: <20180618160028.80602.76507.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C8149@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, June 18, 2018 9:02 AM
> To: shannon.nelson at oracle.com; Fujinaka, Todd
> <todd.fujinaka@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey
> T <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Be more careful
> when modifying MAC filters
> 
> This change makes it so that we are much more explicit about the ordering of
> updates to the receive address register (RAR) table. Prior to this patch I
> believe we may have been updating the table while entries were still active,
> or possibly allowing for reordering of things since we weren't explicitly
> flushing writes to either the lower or upper portion of the register prior to
> accessing the other half.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> I am submitting this as a fix, but I am not certain this actually fixes anything or
> if it is more of just a clean-up. I know there have been some issues with MAC
> address updates reported recently so I decided to review the code and
> found the bits here that I thought needed to be updated.
> Especially the case where we were clearing the lower 32b of the address with
> AV still set in the upper 32b of the register.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


