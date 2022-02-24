From: Joe Damato <jdamato@fastly.com>
Date: Wed, 23 Feb 2022 18:16:35 -0800
Subject: [Intel-wired-lan] i40e and TSO with MPLS ?
In-Reply-To: <DM6PR11MB46572510E594BF3E789AC5CF9B3C9@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <DM6PR11MB4657EB65F784C3E816FD27FB9B3C9@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB46572510E594BF3E789AC5CF9B3C9@DM6PR11MB4657.namprd11.prod.outlook.com>
Message-ID: <CALALjgzQPDdNTjCBD+S2Adymk9XTH4qa4Sb6-kBuh96oKg+ajQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 23, 2022 at 9:56 AM Kubalewski, Arkadiusz
<arkadiusz.kubalewski@intel.com> wrote:
>
> +Joe
>
> > Greetings:
> >
> > Does i40e (XL710) support TSO with MPLS?
> >
> > We are using firmware version: 7.10 0x80006469 1.2527.0
> >
> > We've attempted to add support for TSO+MPLS to i40e, but were unable to
> > get it working. The patch is included below for reference, but it is almost
> > certainly incorrect - and I am not clear if the hardware itself would
> > support this even if the patch was correct.
> >
> > Applying the patch below and using tcpdump shows that:
> >
> >         - packet data, as seen by the pcap filter in the kernel, is large.
> >           This suggests that the kernel is attempting to offload
> >           segmentation to the device,
> >
> >         but
> >
> >         - those large packets are not ACK'd by the client
> >
> > This suggests that either:
> >
> >         - the device does not support TSO + MPLS, and/or
> >         - the patch below is incorrect
> >
> > Does anyone working on i40e have any insight on this?
>
> Hi Joe,
>
> I have done some research for your case, good news is that we believe that 710
> hardware supports it. Currently we do not have plans to implement such feature
> ourselves, but we will do our best in reviewing if you decide to implement it.

OK, thanks. I appreciate the information and your willingness to
review. I am pleased to hear that the hardware supports it.

> Such offloads should be supported on packets with up to 2 MPLS tags before the
> IP header. For start, you might take a look for the features pre check function:
> static netdev_features_t i40e_features_check(struct sk_buff *skb, ...
> It probably requires an update after the changes you have posted.

I took a look at i40e_features_check, as you suggested, but I am
probably missing something.

My understanding is that the call graph on the xmit path is roughly:

__dev_queue_xmit which calls (in order):
1. validate_xmit_skb -- this eventually calls i40e_features_check and
harmonize_features which will use the mpls_features bitfield set in
the patch to turn on the TSO bit

2. dev_hard_start_xmit -- this delivers packets to taps, then to the driver

dev_hard_start_xmit internally hands packets to any taps installed
(for example pcap), before handing them to the driver
(i40e_lan_xmit_frame).

In our tests of the patch below, we see that tcpdump reports large
packet sizes. Since we see them in tcpdump, I think this suggests that
everything leading up to pcap delivery (including i40e_features_check)
is correct... otherwise we'd see smaller packet sizes being delivered
to pcap.

This leads me to believe the issue is somewhere in i40e_lan_xmit_frame
or below -- most likely in i40e_tso, which my patch attempts to tweak.

Let me know if I'm off track and misunderstanding your analysis, but
based on the above, I suspect the changes to i40e_tso are buggy.

Thanks,
Joe
