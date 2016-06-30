From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jun 2016 18:07:58 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Correct parameter sent to
 LED	function
In-Reply-To: <1466197813-17401-1-git-send-email-donald.c.skidmore@intel.com>
References: <1466197813-17401-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E9891@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Friday, June 17, 2016 2:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Correct parameter sent to LED
> function
> 
> The second parameter of these functions is the index to the led we are
> interested in affecting.  However we were mistakingly passing the offset in
> the register.  This patch corrects that and adds some bonds checking which
> would hopefully make bugs like this more noticeable in the future.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 12 ++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Lights function correctly on available hardware.
