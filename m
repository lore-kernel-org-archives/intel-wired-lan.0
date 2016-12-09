From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Dec 2016 23:43:36 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add bounds check for x540
	LED	functions
In-Reply-To: <1478717328-2168-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1478717328-2168-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39D42@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 09, 2016 10:49 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add bounds check for x540 LED
> functions
> 
> This is an extension of commit 003287e0f087 ("ixgbevf: Correct parameter
> sent to LED function"); add bounds checking to x540 functions to ensure the
> index is valid.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


