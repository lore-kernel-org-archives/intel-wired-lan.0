From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 30 May 2019 13:41:15 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the
 skeleton to enable hardware offloading
In-Reply-To: <861F87D1-6A0B-438D-BBD5-6A15BDA398F7@intel.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
 <20190528154510.41b50723@cakuba.netronome.com>
 <62E2DD49-AC21-46DE-8E5B-EBC67230FA7D@intel.com>
 <20190529121440.46c40967@cakuba.netronome.com>
 <A9D05E0B-FC24-4904-B3E5-1E069C92A3DA@intel.com>
 <20190529140620.68fa8e64@cakuba.netronome.com>
 <861F87D1-6A0B-438D-BBD5-6A15BDA398F7@intel.com>
Message-ID: <20190530134115.36f13bb5@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 30 May 2019 00:21:39 +0000, Patel, Vedang wrote:
> > On May 29, 2019, at 2:06 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> > On Wed, 29 May 2019 20:05:16 +0000, Patel, Vedang wrote:  
> >> [Sending the email again since the last one was rejected by netdev because it was html.]
> >>   
> >>> On May 29, 2019, at 12:14 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> >>> 
> >>> On Wed, 29 May 2019 17:06:49 +0000, Patel, Vedang wrote:    
> >>>>> On May 28, 2019, at 3:45 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> >>>>> On Tue, 28 May 2019 10:46:44 -0700, Vedang Patel wrote:      
> >>>>>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >>>>>> 
> >>>>>> This adds the UAPI and the core bits necessary for userspace to
> >>>>>> request hardware offloading to be enabled.
> >>>>>> 
> >>>>>> The future commits will enable hybrid or full offloading for taprio. This
> >>>>>> commit sets up the infrastructure to enable it via the netlink interface.
> >>>>>> 
> >>>>>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >>>>>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>      
> >>>>> 
> >>>>> Other qdiscs offload by default, this offload-level selection here is a
> >>>>> little bit inconsistent with that :(
> >>>>>   
> >>>> There are 2 different offload modes introduced in this patch.
> >>>> 
> >>>> 1. Txtime offload mode: This mode depends on skip_sock_check flag being set in the etf qdisc. Also, it requires some manual configuration which might be specific to the network adapter card. For example, for the i210 card, the user will have to route all the traffic to the highest priority queue and install etf qdisc with offload enabled on that queue. So, I don?t think this mode should be enabled by default.    
> >>> 
> >>> Excellent, it looks like there will be driver patches necessary for
> >>> this offload to function, also it seems your offload enable function
> >>> still contains this after the series:
> >>> 
> >>> 	/* FIXME: enable offloading */
> >>> 
> >>> Please only post offload infrastructure when fully fleshed out and with
> >>> driver patches making use of it.  
> >> 
> >> The above comment refers to the full offload mode described below. It
> >> is not needed for txtime offload mode. Txtime offload mode is
> >> essentially setting the transmit time for each packet  depending on
> >> what interval it is going to be transmitted instead of relying on the
> >> hrtimers to open gates and send packets. More details about why
> >> exactly this is done is mentioned in patch #5[1] of this series.  
> > 
> > From looking at this set it looks like I can add that qdisc to any
> > netdev now *with* offload, and as long as the driver has _any_
> > ndo_setup_tc implementation taprio will not return an error. 
> > 
> > Perhaps this mode of operation should not be called offload?  Can't 
> > the ETF qdisc underneath run in software mode?
> >   
> Yeah, it doesn?t make much sense to run ETF in software mode but it
> can be done. What about naming it txtime-assist instead?

Sounds good!  txtime.* works for me.

> >> What we can do is just add the txtime offload related flag and add
> >> the full offload flag whenever the driver bits are ready. Does that
> >> address your concern?  
> > 
> > That would be a step in the right direction.  And please remove all the
> > other unused code from the series.  AFAICT this is what the enable
> > offload function looks like after your set - what's the point of the
> > 'err' variable?
> >   
> Yes. This patch seems to have a few really silly mistakes. I
> apologize for that. I willl clean it up and send another version of
> the series. There is no unused code anywhere else in the series.

Thanks!
