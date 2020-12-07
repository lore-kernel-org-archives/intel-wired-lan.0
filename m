From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Mon, 7 Dec 2020 13:54:33 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
Message-ID: <20201207135433.41172202@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 4 Dec 2020 16:21:08 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 12/4/20 1:46 PM, Maciej Fijalkowski wrote:
> > On Fri, Dec 04, 2020 at 01:18:31PM +0100, Toke H?iland-J?rgensen wrote:  
> >> alardam at gmail.com writes:  
> >>> From: Marek Majtyka <marekx.majtyka@intel.com>
> >>>
> >>> Implement support for checking what kind of xdp functionality a netdev
> >>> supports. Previously, there was no way to do this other than to try
> >>> to create an AF_XDP socket on the interface or load an XDP program and see
> >>> if it worked. This commit changes this by adding a new variable which
> >>> describes all xdp supported functions on pretty detailed level:  
> >>
> >> I like the direction this is going! :)

(Me too, don't get discouraged by our nitpicking, keep working on this! :-))

> >>  
> >>>   - aborted
> >>>   - drop
> >>>   - pass
> >>>   - tx  
> 
> I strongly think we should _not_ merge any native XDP driver patchset
> that does not support/implement the above return codes. 

I agree, with above statement.

> Could we instead group them together and call this something like
> XDP_BASE functionality to not give a wrong impression?

I disagree.  I can accept that XDP_BASE include aborted+drop+pass.

I think we need to keep XDP_TX action separate, because I think that
there are use-cases where the we want to disable XDP_TX due to end-user
policy or hardware limitations.

Use-case(1): Cloud-provider want to give customers (running VMs) ability
to load XDP program for DDoS protection (only), but don't want to allow
customer to use XDP_TX (that can implement LB or cheat their VM
isolation policy).

Use-case(2): Disable XDP_TX on a driver to save hardware TX-queue
resources, as the use-case is only DDoS.  Today we have this problem
with the ixgbe hardware, that cannot load XDP programs on systems with
more than 192 CPUs.


> If this is properly documented that these are basic must-have
> _requirements_, then users and driver developers both know what the
> expectations are.

We can still document that XDP_TX is a must-have requirement, when a
driver implements XDP.


> >>>   - redirect  
> >>


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

