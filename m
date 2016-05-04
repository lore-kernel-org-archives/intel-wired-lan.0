From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 15:20:38 +0000
Subject: [Intel-wired-lan] [next PATCH S36 01/12] i40e: Add support
	for	disabling all link and change bits needed for PHY interactions.
In-Reply-To: <1462313600-3123-2-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5926@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 01/12] i40e: Add support for
> disabling all link and change bits needed for PHY interactions.
> 
> From: Kevin Scott <kevin.c.scott@intel.com>
> 
> Add flag to tell firmware to disable link on all ports.
> 
> This patch changes the bits set for telling firmware the PHY needs to be
> modified by driver.  Without this patch, the setting will only set that mode for
> the current port on the device.  Because the MDIO interface is common for
> the copper device. The command needs to set the mode for all ports.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I8baa7da91d384291ac95b41ae1a516604f8eb67f
> ---
> Testing Hints :
> Test by blinking led on one
> or more ports on Fort Pond device and do something to interact with the
> other PHY's on the same device at the same time, like lanconf and Dump PHY
> NVM.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h            | 4 +++-
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 +++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to interact with PHY on multiple ports simultaneously
