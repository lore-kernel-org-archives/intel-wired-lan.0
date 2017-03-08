From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Mar 2017 18:51:11 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add check for VETO bit
	when	configuring link for KR
In-Reply-To: <20170301195209.5993-1-anthony.l.nguyen@intel.com>
References: <20170301195209.5993-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402338@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, March 1, 2017 11:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add check for VETO bit when
> configuring link for KR
> 
> We did not have a check in place for MMNGC.MNG_VETO when setting up
> link on X550EM_X KR devices which resulted in link loss for the BMC when
> loading the driver.
> 
> This patch adds a check for ixgbe_check_reset_blocked() in setup_link()
> since in that case there is no PHY reset function.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


