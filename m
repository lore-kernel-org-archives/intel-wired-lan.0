From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 17:59:48 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add work around for empty
	SFP+	cage crosstalk
In-Reply-To: <1460503510-33043-1-git-send-email-donald.c.skidmore@intel.com>
References: <1460503510-33043-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D225F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Tuesday, April 12, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add work around for empty SFP+
> cage crosstalk
> 
> It is possible on some systems that crosstalk could lead to link flap on empty
> SFP+ cages.  A new NVM bit was defined to let SW know it needs to
> implement the work around which consists of verifying that there is a
> module in the cage before acting on the LSC.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 39
> +++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
>  3 files changed, 42 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No stray link up events noted after heavy traffic on adjacent cage
