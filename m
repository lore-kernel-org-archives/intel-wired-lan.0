From: John Fastabend <john.fastabend@gmail.com>
Date: Tue, 08 Dec 2020 22:03:51 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <20201207230755.GB27205@ranger.igk.intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
Message-ID: <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Mon, Dec 07, 2020 at 12:52:22PM -0800, John Fastabend wrote:
> > Jesper Dangaard Brouer wrote:
> > > On Fri, 4 Dec 2020 16:21:08 +0100
> > > Daniel Borkmann <daniel@iogearbox.net> wrote:

[...] pruning the thread to answer Jesper.

> > > 
> > > Use-case(2): Disable XDP_TX on a driver to save hardware TX-queue
> > > resources, as the use-case is only DDoS.  Today we have this problem
> > > with the ixgbe hardware, that cannot load XDP programs on systems with
> > > more than 192 CPUs.
> > 
> > The ixgbe issues is just a bug or missing-feature in my opinion.
> 
> Not a bug, rather HW limitation?

Well hardware has some max queue limit. Likely <192 otherwise I would
have kept doing queue per core on up to 192. But, ideally we should
still load and either share queues across multiple cores or restirct
down to a subset of CPUs. Do you need 192 cores for a 10gbps nic,
probably not. Yes, it requires some extra care, but should be doable
if someone cares enough. I gather current limitation/bug is because
no one has that configuration and/or has complained loud enough.

> 
> > 
> > I think we just document that XDP_TX consumes resources and if users
> > care they shouldn't use XD_TX in programs and in that case hardware
> > should via program discovery not allocate the resource. This seems
> > cleaner in my opinion then more bits for features.
> 
> But what if I'm with some limited HW that actually has a support for XDP
> and I would like to utilize XDP_TX?
> 
> Not all drivers that support XDP consume Tx resources. Recently igb got
> support and it shares Tx queues between netstack and XDP.

Makes sense to me.

> 
> I feel like we should have a sort-of best effort approach in case we
> stumble upon the XDP_TX in prog being loaded and query the driver if it
> would be able to provide the Tx resources on the current system, given
> that normally we tend to have a queue per core.

Why do we need to query? I guess you want some indication from the
driver its not going to be running in the ideal NIC configuraition?
I guess printing a warning would be the normal way to show that. But,
maybe your point is you want something easier to query?

> 
> In that case igb would say yes, ixgbe would say no and prog would be
> rejected.

I think the driver should load even if it can't meet the queue per
core quota. Refusing to load at all or just dropping packets on the
floor is not very friendly. I think we agree on that point.
