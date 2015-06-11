From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 11 Jun 2015 16:35:44 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <CAEP_g=-DPCx5_OCJoPPg-vkFkZ3T1an+jh7MOs3Ja8jZCDkMGg@mail.gmail.com>
References: <20150610174304.85125.18769.stgit@mdrustad-wks.jf.intel.com>
 <20150610174426.85125.33055.stgit@mdrustad-wks.jf.intel.com>
 <CAEP_g=-DPCx5_OCJoPPg-vkFkZ3T1an+jh7MOs3Ja8jZCDkMGg@mail.gmail.com>
Message-ID: <0AF8A847-ECEE-4FCA-B6E0-86B9169A14EF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 10, 2015, at 11:58 AM, Jesse Gross <jesse@nicira.com> wrote:
> 
> On Wed, Jun 10, 2015 at 10:44 AM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 03336013a76c..3c9bc7cc7d10 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +static netdev_features_t
>> +ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
>> +                    netdev_features_t features)
>> +{
>> +       return vxlan_features_check(skb, features);
>> +}
> 
> Do you know what the actual capabilities of the device are? My guess
> is that in practice you can have a more liberal feature check and
> support a greater range of protocols. Something like this:
> https://patchwork.ozlabs.org/patch/461323/

I will look further into this. With the number of devices involved it will take me some time.

> Also, does this patch support TSO or just checksums?

It relies on GSO for segmentation so the hardware can do the checksumming.

> It looks like
> checksums only but in that case it shouldn't expose
> NETIF_F_GSO_UDP_TUNNEL.

I thought that was what I needed to set to get GSO to be used on the tunnel. If that isn't what this does, it is very badly-named.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150611/91aa78ea/attachment.asc>
