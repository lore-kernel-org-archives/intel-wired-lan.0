From: Basierski, SebastianX <sebastianx.basierski@intel.com>
Date: Fri, 3 Aug 2018 07:33:17 +0000
Subject: [Intel-wired-lan] IXGBE driver questions
In-Reply-To: <da133a858c09b8c4192ae04149836f9a326552eb.camel@intel.com>
References: <CA+WKCcmYi+BeodZy_xdtWrjN05emwJ2Xhm5Lp0Y1tMS1E5kQow@mail.gmail.com>
 <da133a858c09b8c4192ae04149836f9a326552eb.camel@intel.com>
Message-ID: <3A7E81AC661B4646A4CE6F2E09B7B74E05C6518C@HASMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, August 2, 2018 9:56 PM
> To: Valery Kobyzev <valery.kobyzev@gmail.com>; intel-wired-lan <intel-
> wired-lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] IXGBE driver questions
> 
> On Tue, 2018-07-31 at 20:19 +0300, Valery Kobyzev wrote:
> > Hello,
> >
> > I found your email as commiters to ixgbe drivers.
> >
> > I start work very closely with 82599 equipment and nice things like as
> > Flow Director and SR-IOV.
> >
> > And I have several questions without answer.
> >
> > 1) flow-director have 8k perfect filters. If I will be have 2k filters
> > and speed 10 mpps are possible? Any drawbacks?
Sorry, I do not think I have means to check this any time soon.

> >
> > 2) I found user-def instruction. But don't see how it work.
Please check i40e driver documentation -> https://www.kernel.org/doc/Documentation/networking/i40e.txt
There You can find a description of user-def.
 
> >
> > 3) Is it possible to filter ipv4/ether frames with fixed offset in
> > frame? Any examples?
Maybe You could try TC with u32 hw offload?

> >
> > 4) How I can patched (provide additional functions by ethtool) to make
> > 82599 card as white list? 
Please explain what You want to achieve.

>> Is it possible to drop all packets that not present in flow director filters?
There is a possibility to create a drop filter using FDIRCTRL.DROP-Queue.
Please try to insert as last filter in chain something like 'ethtool -U eth1 flow-type ip4 action -1'.
Though I can't guarantee if it will work exactly as You want.
	?
	?
Or maybe You could use XDP - it is a good solution for black/whitelist filtering (can also use offsets and whole IP/ether structure manipulating in filter program).

Thanks 
Sebastian Basierski
