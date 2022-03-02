From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
Date: Wed, 2 Mar 2022 21:10:00 +0000
Subject: [Intel-wired-lan] i40e and TSO with MPLS ?
In-Reply-To: <CALALjgyJhZLZALV5w3C-Etus8ZCRzeCBpwYVZgF9VUQptAQMjQ@mail.gmail.com>
References: <DM6PR11MB4657EB65F784C3E816FD27FB9B3C9@DM6PR11MB4657.namprd11.prod.outlook.com>
 <DM6PR11MB46572510E594BF3E789AC5CF9B3C9@DM6PR11MB4657.namprd11.prod.outlook.com>
 <CALALjgzQPDdNTjCBD+S2Adymk9XTH4qa4Sb6-kBuh96oKg+ajQ@mail.gmail.com>
 <DM6PR11MB4657CBB8B06ACCAB0CE201429B3D9@DM6PR11MB4657.namprd11.prod.outlook.com>
 <CALALjgxJ-=WbWBS0VxxSNWA17L6mMZA7xZa-XBBeOsYy6KujEQ@mail.gmail.com>
 <DM6PR11MB46572379068898154F187F889B029@DM6PR11MB4657.namprd11.prod.outlook.com>
 <CALALjgyJhZLZALV5w3C-Etus8ZCRzeCBpwYVZgF9VUQptAQMjQ@mail.gmail.com>
Message-ID: <DM6PR11MB465794A7D38CFD093B81C9479B039@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Tue, Mar 1, 2022 at 5:58 AM Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com> wrote:
> >
> > > On Thu, Feb 24, 2022 at 6:28 AM Kubalewski, Arkadiusz
> > > <arkadiusz.kubalewski@intel.com> wrote:
> > > >
> > > > > On Wed, Feb 23, 2022 at 9:56 AM Kubalewski, Arkadiusz
> > > > > <arkadiusz.kubalewski@intel.com> wrote:
> > > > > >
> > > > > > +Joe
> > > > > >
> > > > > > > Greetings:
> > > > > > >
> > > > > > > Does i40e (XL710) support TSO with MPLS?
> > > > > > >
> > > > > > > We are using firmware version: 7.10 0x80006469 1.2527.0
> > > > > > >
> > > > > > > We've attempted to add support for TSO+MPLS to i40e, but were unable to
> > > > > > > get it working. The patch is included below for reference, but it is almost
> > > > > > > certainly incorrect - and I am not clear if the hardware itself would
> > > > > > > support this even if the patch was correct.
> > > > > > >
> > > > > > > Applying the patch below and using tcpdump shows that:
> > > > > > >
> > > > > > >         - packet data, as seen by the pcap filter in the kernel, is large.
> > > > > > >           This suggests that the kernel is attempting to offload
> > > > > > >           segmentation to the device,
> > > > > > >
> > > > > > >         but
> > > > > > >
> > > > > > >         - those large packets are not ACK'd by the client
> > > > > > >
> > > > > > > This suggests that either:
> > > > > > >
> > > > > > >         - the device does not support TSO + MPLS, and/or
> > > > > > >         - the patch below is incorrect
> > > > > > >
> > > > > > > Does anyone working on i40e have any insight on this?
> > > > > >
> > > > > > Hi Joe,
> > > > > >
> > > > > > I have done some research for your case, good news is that we believe that 710
> > > > > > hardware supports it. Currently we do not have plans to implement such feature
> > > > > > ourselves, but we will do our best in reviewing if you decide to implement it.
> > > > >
> > > > > OK, thanks. I appreciate the information and your willingness to
> > > > > review. I am pleased to hear that the hardware supports it.
> > > > >
> > > > > > Such offloads should be supported on packets with up to 2 MPLS tags before the
> > > > > > IP header. For start, you might take a look for the features pre check function:
> > > > > > static netdev_features_t i40e_features_check(struct sk_buff *skb, ...
> > > > > > It probably requires an update after the changes you have posted.
> > > > >
> > > > > I took a look at i40e_features_check, as you suggested, but I am
> > > > > probably missing something.
> > > > >
> > > > > My understanding is that the call graph on the xmit path is roughly:
> > > > >
> > > > > __dev_queue_xmit which calls (in order):
> > > > > 1. validate_xmit_skb -- this eventually calls i40e_features_check and
> > > > > harmonize_features which will use the mpls_features bitfield set in
> > > > > the patch to turn on the TSO bit
> > > > >
> > > > Just saying, worth to check if the required flags are already set when
> > > > i40e_features_check was called.
> > > >
> > > > > 2. dev_hard_start_xmit -- this delivers packets to taps, then to the driver
> > > > >
> > > > > dev_hard_start_xmit internally hands packets to any taps installed
> > > > > (for example pcap), before handing them to the driver
> > > > > (i40e_lan_xmit_frame).
> > > > >
> > > > > In our tests of the patch below, we see that tcpdump reports large
> > > > > packet sizes. Since we see them in tcpdump, I think this suggests that
> > > > > everything leading up to pcap delivery (including i40e_features_check)
> > > > > is correct... otherwise we'd see smaller packet sizes being delivered
> > > > > to pcap.
> > > > >
> > > > > This leads me to believe the issue is somewhere in i40e_lan_xmit_frame
> > > > > or below -- most likely in i40e_tso, which my patch attempts to tweak.
> > > > >
> > > > > Let me know if I'm off track and misunderstanding your analysis, but
> > > > > based on the above, I suspect the changes to i40e_tso are buggy.
> > > > >
> > > >
> > > > Seems like your understanding is correct.
> > > > Are those packets actually sent to the wire?
> > > > Any stats are incremented?
> > > > Anything at all shows up on the client?
> > >
> > > The bytes are never ACK'd by the client and are eventually re-transmit.
> > >
> > > Based on the tcpdump output I think the packet data makes it to the
> > > driver unsegmented (which is what we want), but due to some issue in
> > > i40e_tso (or a hardware limitation) the NIC fails to TSO the bytes and
> > > they are eventually re-transmit.
> > >
> >
> > I think good place to start would be the 710 datasheet:
> > https://cdrdv2.intel.com/v1/dl/getContent/332464?explicitVersion=true
> > i.e. 8.4.4.3.2 Transmit Segmentation Flow
> > Please verify if your change is following the expected flow,
> 
> I think I found the issue.
> 
> The original patch only modified i40e_tso, but I needed two more tweaks:
> 
> - a similar change is needed in i40e_tx_enable_csum.
> - tx_flags need to be tweaked slightly so that the l4 protocol
> detection works in i40e_tx_enable_csum.
> 
> Tests in my test environment show large MPLS packet TX which are now
> ACK'd by the client :)
> 
> I will submit this patch to the mailing list now and CC you on it for
> a formal review.
> 
> I noticed ice probably needs the same change (assuming it supports
> mpls+tso), but I don't have any ice hardware to test on. I am happy to
> port this change to the ice driver and submit that as well, if you
> like, but I'll need to ask the ice folks to test on my behalf.
> 
> Let me know if you'd like me to submit to ice, as well.
> 
> Thanks,
> Joe
> 

Hi Joe,

Great to hear that! :)

If you think that it is required to enable MPLS+TSO on ice, you can also submit
the patch there. When the patch is submitted to intel-wired-lan they are
passed to validation team,  and once they are reviewed and validated, our
maintainer will propose them to be merged into Dave's next-tree.

Thanks,
Arek
