From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 29 Apr 2021 16:15:15 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix broken XDP support
In-Reply-To: <20210429111056.2174ee76@carbon>
References: <20210426111401.28369-1-magnus.karlsson@gmail.com>
 <20210429111056.2174ee76@carbon>
Message-ID: <e1d4c3da623201bbbe9395477d7cd077638b4bf6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-04-29 at 11:10 +0200, Jesper Dangaard Brouer wrote:
> Hi Tony, (+ Kuba and DaveM),
> 
> What is the status on this patch[2] that fixes a crash[1] for i40e
> driver?

They are currently applied to the Intel-wired-lan tree[1] awaiting
validation.

> I'm getting offlist and internal IRC questions to why i40e doesn't
> work, and I noticed that it seems this have not been applied.
> 
> I don't see it in net-next or net tree... would it make sense to
> route
> this via DaveM, or does it depend on the other fixes for i40e.

There are no other dependent changes I'm aware of. As this resolves the
issue for you, I'll go ahead and send this patch to DaveM.

Thanks,
Tony


[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/patch/20210426111401.28369-1-magnus.karlsson at gmail.com/

> [1] https://lore.kernel.org/netdev/20210422170508.22c58226 at carbon/
> [2] 
> https://patchwork.kernel.org/project/netdevbpf/patch/20210426111401.28369-1-magnus.karlsson at gmail.com/
> 
> (top-post)
> 
> On Mon, 26 Apr 2021 13:14:01 +0200
> Magnus Karlsson <magnus.karlsson@gmail.com> wrote:
> 
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > 
> > Commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")
> > broke
> > XDP support in the i40e driver. That commit was fixing a sparse
> > error
> > in the code by introducing a new variable xdp_res instead of
> > overloading this into the skb pointer. The problem is that the code
> > later uses the skb pointer in if statements and these where not
> > extended to also test for the new xdp_res variable. Fix this by
> > adding
> > the correct tests for xdp_res in these places.
> > 
> > The skb pointer was used to store the result of the XDP program by
> > overloading the results in the errror pointer
> > ERR_PTR(-result). Therefore, the allocation failure test that used
> > to
> > only test for !skb now need to be extended to also consider
> > !xdp_res.
> > 
> > i40e_cleanup_headers() had a check that based on the skb value
> > being
> > an error pointer, i.e. a result from the XDP program != XDP_PASS,
> > and
> > if so start to process a new packet immediately, instead of
> > populating
> > skb fields and sending the skb to the stack. This check is not
> > needed
> > anymore, since we have added an explicit test for xdp_res being set
> > and if so just do continue to pick the next packet from the NIC.
> > 
> > v1 -> v2:
> > 
> > * Improved commit message.
> > 
> > * Restored the xdp_res = 0 initialization to its original place
> >   outside the per-packet loop. The original reason to move it
> > inside
> >   the loop was that it was only initialized inside the loop code if
> >   skb was not set. But as skb can only be non-null if we have
> > packets
> >   consisting of multiple frames (skb is set for all frames except
> > the
> >   last one in a packet) and when this is true XDP cannot be active,
> > so
> >   this does not matter. xdp_res == 0 is the same as I40E_XDP_PASS
> >   which is the default action if XDP is not active and it is then
> > true
> >   for every single packet in this case.
> > 
> > Fixes: 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")
> > Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> 
