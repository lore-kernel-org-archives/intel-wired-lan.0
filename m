From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Tue, 13 Mar 2018 19:05:19 +0000
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180309151428.4d73358c@cakuba.netronome.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
Message-ID: <1520967916.696.21.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2018-03-09 at 15:14 -0800, Jakub Kicinski wrote:
> On Fri,  9 Mar 2018 09:21:33 -0800, Anirudh Venkataramanan wrote:
> > +static const struct ice_stats ice_net_stats[] = {
> > +	ICE_NETDEV_STAT(rx_packets),
> > +	ICE_NETDEV_STAT(tx_packets),
> > +	ICE_NETDEV_STAT(rx_bytes),
> > +	ICE_NETDEV_STAT(tx_bytes),
> > +	ICE_NETDEV_STAT(rx_errors),
> > +	ICE_NETDEV_STAT(tx_errors),
> > +	ICE_NETDEV_STAT(rx_dropped),
> > +	ICE_NETDEV_STAT(tx_dropped),
> > +	ICE_NETDEV_STAT(multicast),
> > +	ICE_NETDEV_STAT(rx_length_errors),
> > +	ICE_NETDEV_STAT(rx_crc_errors),
> > +};
> 
> Please don't duplicate standard netdev stats in ethtool -S.

Jacub,

Thanks for the feedback. I am not sure I understand what's being asked
here. Do you mean to say that standard netdev stats should not be
printed when we do ethtool -S or something else?

Thanks!
Ani
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180313/ba4111cb/attachment.bin>
