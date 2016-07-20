From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 20:20:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Add lock
	around	ixgbevf_reinit_locked call.
In-Reply-To: <1468286996-27931-1-git-send-email-donald.c.skidmore@intel.com>
References: <1468286996-27931-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF10@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Monday, July 11, 2016 6:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Add lock around
> ixgbevf_reinit_locked call.
> 
> The function ixgbevf_reinit_locked() assumes you have the rtnl lock
> however we didn't when calling from the service task.  This patch corrects
> that.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
