From: Jesse Gross <jesse@nicira.com>
Date: Wed, 9 Sep 2015 17:52:06 -0700
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
	encapulation
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418AF7DB60@fmsmsx115.amr.corp.intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
 <CAEP_g=88Nu8uOM0jvd1MTWpwy2+nWst9YQEeWibVt2Zm5mpT0A@mail.gmail.com>
 <E8A77B2FB54C194393A5C2A8E3ED1678266F3BA6@CRSMSX102.amr.corp.intel.com>
 <FC41C24E35F18A40888AACA1A36F3E418AF7DB60@fmsmsx115.amr.corp.intel.com>
Message-ID: <CAEP_g=--LZxDTTVuOBSqCrppyF8p5o-2J0QQDC3=1YXGYxN8VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 9, 2015 at 4:32 PM, Nelson, Shannon
<shannon.nelson@intel.com> wrote:
>> > From: Jesse Gross [mailto:jesse at nicira.com]
>> > On Fri, Aug 28, 2015 at 2:56 PM, Catherine Sullivan
>> > <catherine.sullivan@intel.com> wrote:
>> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > > index 469e1d5..b686450 100644
>> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > [...]
>> > > +#if IS_ENABLED(CONFIG_VXLAN)
>> > > +       return vxlan_features_check(skb, features); #else
>> > >         return features;
>> > > +#endif
>> >
>> > I don't think this is right - when VXLAN is compiled in, it will
>> restrict offload
>> > capabilities to that of VXLAN. But when there is no VXLAN support, all
>> tunnel
>> > types will be allowed. Presumably, there is some underlying hardware
>> > capability here for both situations (and maybe even for GRE as well).
>
> I don't understand where you this restriction.  Looking at the code in vxlan_features_check(), it looks to me that the features bits are mangled only if IPPROTO_UDP is set AND the other header parameters don't match VXLAN needs.  If there is no encapsulation, or it is something other than IPPROTO_UDP (e.g. IPPROTO_GRE), then there is no change to the features bits.
>
> If you are referring to other tunneling protocols that might call themselves IPROTO_UDP, then I would think there is a problem in the implementation of vxlan_features_check(), not in how we call it.  In that case, vxlan_features_check() should be looking at some additional flag to assure VXLAN before verifying the other header parameters.
>
> What am I missing?  Are you thinking that our calling code should look for some additional VXLAN flag before calling vxlan_features_check()?

VXLAN is not the only UDP based encapsulation, so there are other
protocols that call themselves that. (I'm not quite sure what you mean
by this, it seems to imply that these protocols are somehow spoofing
something. They're not - they and VXLAN are all layered under UDP).
However, I don't think that's really the issue.

The point that I was trying to make is that there is an underlying
hardware capability as far as the types of protocols that are
understood, lengths of headers, etc. and the goal of this function is
to remove any offload features that can't be supported so the core
stack doesn't use them. vxlan_features_check() will do this by
chopping down the general NETIF_F_GSO_UDP_TUNNEL feature to only allow
headers that look like VXLAN. However, if VXLAN is not compiled in,
then with this patch that restriction won't take place and the driver
will actually receive packets with more offloads than it otherwise
would. These can come from other UDP protocols which can still be
enabled even if VXLAN is not. In this case, these protocols will
break.

That being said, I also happen to know that the underlying hardware is
capable of supporting more than just VXLAN. In particular, it supports
Geneve, which is also a UDP based protocol. Using
vxlan_features_check() here will remove offload support for at least
some types of Geneve packets, so this is a little heavy handed.

To make a long story short, it looks like the actual problem here is
that only UDP tunnels are supported (since that is all that is checked
in i40e_tx_enable_csum()). In that case, I think you could simply do:

if ((protocol != IPPROTO_UDP))
    return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);

And that would solve the above concerns as well as catch some
additional problematic cases.
