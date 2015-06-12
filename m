From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 12 Jun 2015 18:01:40 +0000
Subject: [Intel-wired-lan] [PATCH V2 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <CAEP_g=9-bLgncpqX0nP4+r-mrRzSyza4FXtLeAmeSMYCC-X9Rw@mail.gmail.com>
References: <20150612003527.22911.62812.stgit@mdrustad-wks.jf.intel.com>
 <20150612003659.22911.5645.stgit@mdrustad-wks.jf.intel.com>
 <CAEP_g=9-bLgncpqX0nP4+r-mrRzSyza4FXtLeAmeSMYCC-X9Rw@mail.gmail.com>
Message-ID: <854BEC3F-77DC-4ADE-9CBA-9D3A18D49AE1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 11, 2015, at 6:56 PM, Jesse Gross <jesse@nicira.com> wrote:
> 
> On Thu, Jun 11, 2015 at 5:37 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 3bf2f3cfd9f6..64e6bda05da9 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> [...]
>> +#define IXGBE_MAX_TUNNEL_HDR_LEN 80
>> +static netdev_features_t
>> +ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
>> +                    netdev_features_t features)
>> +{
>> +       if (!skb->encapsulation)
>> +               return features;
>> +
>> +       if (skb_inner_mac_header(skb) - skb_transport_header(skb) >
>> +           IXGBE_MAX_TUNNEL_HDR_LEN)
>> +               return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
>> +
>> +       return features & ~NETIF_F_ALL_TSO;
>> +}
> 
> Thanks, this looks nice. One suggestion - you shouldn't need to remove
> either NETIF_F_GSO_MASK or NETIF_F_ALL_TSO. Since neither of these
> were included in the original encapsulation flags we don't need to
> remove them at this point.

Yes, I was thinking too pedantically as I wrote this. Making that change will take instructions out of the encapsulation hot path, so I will certainly make that change. Maybe I should also put an unlikely around the offset check, since that should be very unlikely to be true.

Thank you so much for your reviews!

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150612/e75eb40c/attachment.asc>
