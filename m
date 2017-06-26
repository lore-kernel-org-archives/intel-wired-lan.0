From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Jun 2017 14:11:52 -0700
Subject: [Intel-wired-lan] [PATCH] Added SIOCSMIIREG (mii write) support
 to intel igb driver
In-Reply-To: <20170622132356.2567-1-michael.moese@men.de>
References: <20170622132356.2567-1-michael.moese@men.de>
Message-ID: <1498511512.3237.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-06-22 at 15:23 +0200, Michael Moese wrote:
> From: Andreas Werner <andreas.werner@men.de>
> 
> Signed-off-by: Andreas Werner <andreas.werner@men.de>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> ?1 file changed, 4 insertions(+)

NACK

Why?  Your lack of patch description does not provide a reasoning on why we
need this change.  I need a patch description that provides justification
on why we need this change, before I add this to my queue for testing and
acceptance upstream.

Please resubmit with the requested information/change.

> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 1cf74aa4ebd9..87e496eeefb1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -7716,6 +7716,10 @@ static int igb_mii_ioctl(struct net_device
> *netdev, struct ifreq *ifr, int cmd)
> ?			return -EIO;
> ?		break;
> ?	case SIOCSMIIREG:
> +		if (igb_write_phy_reg(&adapter->hw, data->reg_num &
> 0x1F,
> +				??????data->val_in))
> +			return -EIO;
> +		break;
> ?	default:
> ?		return -EOPNOTSUPP;
> ?	}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170626/1ff7d9df/attachment-0001.asc>
