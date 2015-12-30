From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 30 Dec 2015 19:02:54 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: synchronize the link_speed
 and link_up of a slave interface
In-Reply-To: <1451466995-19015-4-git-send-email-zyjzyj2000@gmail.com>
References: <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
 <1451466995-19015-1-git-send-email-zyjzyj2000@gmail.com>
 <1451466995-19015-4-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <7EED4F91-2DE5-407F-BA6A-681ED57650E4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

zyjzyj2000 at gmail.com wrote:

> From: Zhu Yanjun <yanjun.zhu@windriver.com>
> 
> According to the suggestion from Rustad, Mark D, this behavior perhaps
> is more related to the copper phy. But to make fiber phy more robust,
> to all the interfaces as a slave interface, the link_speed and link_up
> is synchronized.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@windriver.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 1bb6056..ce47639 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6441,10 +6441,12 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
> 	 * a bonding driver in 802.3ad mode. When X540 NIC acts as an
> 	 * independent interface, it is not necessary to synchronize link_up
> 	 * and link_speed.
> -	 * In the end, not continue if (X540 NIC && SLAVE && link_speed UNKNOWN)
> +	 * According to the suggestion from Rustad, Mark D, this behavior
> +	 * perhaps is related to the copper phy. To make fiber phy more robust,
> +	 * To all the interfaces as a slave, the link_speed is checked.
> +	 * In the end, not continue if (SLAVE && link_speed UNKNOWN)

There is no need to make reference to my suggestion in the comment, especially since that is in the commit message. Please simplify your comment above to be something like:
	 * For all slave interfaces, wait for the link_speed to be known.

> 	 */
> -	if ((hw->mac.type == ixgbe_mac_X540) &&
> -	    (netdev->flags & IFF_SLAVE))
> +	if (netdev->flags & IFF_SLAVE)
> 		if (link_speed == IXGBE_LINK_SPEED_UNKNOWN)
> 			return;

The above would be better as:
	if ((netdev->flags & IFF_SLAVE) &&
	    link_speed == IXGBE_LINK_SPEED_UNKNOWN)
		return;

Please do not send a series of patches - it just adds needless confusion and is a bisect hazard. Just send a single patch with the desired change as a V5.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151230/5415a7a9/attachment.asc>
