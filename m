From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 19 Apr 2018 17:47:14 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix insufficient memory issue in
 ice_aq_manage_mac_read
In-Reply-To: <20180416170703.9153-1-anirudh.venkataramanan@intel.com>
References: <20180416170703.9153-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26194C8BAE@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Monday, April 16, 2018 10:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Fix insufficient memory issue in
> ice_aq_manage_mac_read
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> For the MAC read operation, the device can return upto two (LAN and WoL)
> MAC addresses. Without access to adequate memory, the device will return
> an error. Fixed this by allocating the right amount of memory. Also, logic to
> detect and copy the LAN MAC address into the port_info structure has been
> added. Note that the WoL MAC address is ignored currently as the WoL
> feature isn't supported yet.
> 
> Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler topology")
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 22 +++++++++++++++++----
> -
>  1 file changed, 17 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


