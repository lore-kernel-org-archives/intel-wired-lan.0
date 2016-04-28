From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Apr 2016 16:14:22 +0000
Subject: [Intel-wired-lan] [next-queue v2] ixgbevf: Remove unused
 parameter
In-Reply-To: <1461791654-68864-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1461791654-68864-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D521F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, April 27, 2016 2:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2] ixgbevf: Remove unused
> parameter
> 
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> ixgbevf_update_xcast_mode() is not using the netdev parameter; removing
> it since it's unnecessary.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: original patch was not against Jeff's dev-queue branch so did not
>     take into consideration all the changes/patches that are in his queue
> 
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 7 ++-----
>  drivers/net/ethernet/intel/ixgbevf/vf.h           | 2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
