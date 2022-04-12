From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 12 Apr 2022 00:08:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 02/12] taprio: Add support
 for frame preemption offload
In-Reply-To: <874k2zdwp4.fsf@intel.com>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
 <20210626003314.3159402-3-vinicius.gomes@intel.com>
 <20210627195826.fax7l4hd2itze4pi@skbuf> <874k2zdwp4.fsf@intel.com>
Message-ID: <20220412000759.wtsebxkayb5vssvx@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Apr 11, 2022 at 04:31:03PM -0700, Vinicius Costa Gomes wrote:
> > First line in taprio_disable_offload() is:
> >
> > 	if (!FULL_OFFLOAD_IS_ENABLED(q->flags))
> > 		return 0;
> >
> > but you said it yourself below that the preemptible queues thing is
> > independent of whether you have taprio offload or not (or taprio at
> > all). So the queues will never be reset back to the eMAC if you don't
> > use full offload (yes, this includes txtime offload too). In fact, it's
> > so independent, that I don't even know why we add them to taprio in the
> > first place :)
>
> That I didn't change taprio_disable_offload() was a mistake caused in
> part by the limitations of the hardware I have (I cannot have txtime
> offload and frame preemption enabled at the same time), so I didn't
> catch that.
>
> > I think the argument had to do with the hold/advance commands (other
> > frame preemption stuff that's already in taprio), but those are really
> > special and only to be used in the Qbv+Qbu combination, but the pMAC
> > traffic classes? I don't know... Honestly I thought that me asking to
> > see preemptible queues implemented for mqprio as well was going to
> > discourage you, but oh well...
>
> Now, the real important part, if this should be communicated to the
> driver via taprio or via ethtool/netlink.
>
> I don't really have strong opinions on this anymore, the two options are
> viable/possible.
>
> This is going to be a niche feature, agreed, so thinking that going with
> the one that gives the user more flexibility perhaps is best, i.e. using
> ethtool/netlink to communicate which queues should be marked as
> preemptible or express.

So we're back at this, very well.

I was just happening to be looking at clause 36 of 802.1Q (Priority Flow Control),
a feature exchanged through DCBX where flows of a certain priority can be
configured as lossless on a port, and generate PAUSE frames. This is essentially
the extension of 802.3 annex 31B MAC Control PAUSE operation with the ability to
enable/disable flow control on a per-priority basis.

The priority in PFC (essentially synonymous with "traffic class") is the same
priority as the priority in frame preemption. And you know how PFC is configured
in Linux? Not through the qdisc, but through DCB_ATTR_PFC_CFG, a nested dcbnl
netlink attribute with one nested u8 attribute per priority value
(DCB_PFC_UP_ATTR_0 to DCB_PFC_UP_ATTR_7).

Not saying we should follow the exact same model as PFC, just saying that I'm
hard pressed to find a good reason why the "preemptable traffic classes"
information should sit in a layer which is basically independent of the frame
preemption feature itself.
