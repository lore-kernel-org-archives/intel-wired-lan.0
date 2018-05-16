From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 16 May 2018 11:14:49 -0700
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 00/12] AF_XDP,
 zero-copy support
In-Reply-To: <20180516170427.7jq74odw62myg55x@ast-mbp>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180516170427.7jq74odw62myg55x@ast-mbp>
Message-ID: <2af597cb63e5211ab76c1fef75cb294d6fe88bc0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-05-16 at 10:04 -0700, Alexei Starovoitov wrote:
> On Tue, May 15, 2018 at 09:06:03PM +0200, Bj?rn T?pel wrote:
> > 
> > Alexei had two concerns in conjunction with adding ZC support to
> > AF_XDP: show that the user interface holds and can deliver good
> > performance for ZC and that the driver interfaces for ZC are good.
> > We
> > think that this patch set shows that we have addressed the first
> > issue: performance is good and there is no change to the uapi. But
> > please take a look at the code and see if you like the ZC
> > interfaces
> > that was the second concern.
> 
> Looks like we're not on the same page with definition of 'uapi'.
> Here you're saying that patches demonstrate performance without
> a change to uapi, whereas patch 1 does remove rebind support
> which _is_ a change to uapi.
> That was exactly my concern with the previous set.
> 
> The other restrictions that are introduced in this patch set
> are actually ok:
> - like in patch 12: 'no redirect to an AF_XDP enabled XDP Tx ring'
>   this is fine, since this restriction can be lifted later without
>   breaking uapi
> - patch 11: 'No passing to the stack via XDP_PASS'
>   also fine, since can be addressed later.
> 
> > To do for this RFC to become a patch set:
> > 
> > * Implement dynamic creation and deletion of queues in the i40e
> > driver
> 
> can be deferred, no?
> 
> > * Properly splitting up the i40e changes
> 
> Imo patch 11 and 12 are reasonable in terms of size
> and reviewable as-is. I don't think they have to be split.
> Would be nice though.
>  
> > * Have the Intel NIC team review the i40e changes from at least an
> >   architecture point of view
> 
> As Alexander pointed out in patch 11, if you split it into
> separate file the changes to i40e core become pretty small and
> I think Intel folks (Jeff, Alexander, ...) will be ok if we merge
> this set via bpf-next tree asap and clean up, refactor, share
> more code with i40e core later.

I am fine with the i40e changes in this series go through the BPF tree,
since majority of the series is BPF changes.  We just need to address
Alex's comments on patch 11 & 12.

I only have 1-2 patches currently in my queue against i40e and they are
not affected by the changes in this series, so Dave should not have any
merge issues when pulling.

> > * Implement a more fair scheduling policy for multiple XSKs that
> > share
> >   an umem for TX. This can be combined with a batching API for
> >   xsk_umem_consume_tx.
> 
> can be deferred too?
> 
> I think the first 10 patches in this set is a hard dependency on i40e
> patches, so the whole thing have to reviewed and landed together.
> May be the first 5 patches can be applied already.
> 
> Anyway at this point I still think that removing AF_XDP and bpf
> xskmap
> from uapi is necessary before the merge window, unless this patch set
> (including i40e changes can land right now).
> Also I'd like to see another NIC vendor demonstrating RFC for ZC as
> well.
> The allocator api looks good and I don't anticipate issues, but still
> I think it's necessary to make sure that we're not adding i40e-only
> feature.
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180516/a0a513ef/attachment.asc>
