From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 10 Dec 2016 00:05:59 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix check
	for	ixgbe_phy_x550em_ext_t reset
In-Reply-To: <1477941118-17973-1-git-send-email-anthony.l.nguyen@intel.com>
References: <1477941118-17973-1-git-send-email-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39D89@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, October 31, 2016 12:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix check for
> ixgbe_phy_x550em_ext_t reset
> 
> The generic PHY reset check we had previously is not sufficient for the
> ixgbe_phy_x550em_ext_t PHY type.  Check 1.CC02.0 instead - same as
> ixgbe_init_ext_t_x550().
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 25
> +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


