From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 16 Jun 2016 17:10:06 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the
	work done
In-Reply-To: <CAHdzE-8V8o9sg9xmiJ9J0G3u=k6K-fHQssb5v09TPJvN2N=a1Q@mail.gmail.com>
References: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
 <CAHdzE-8V8o9sg9xmiJ9J0G3u=k6K-fHQssb5v09TPJvN2N=a1Q@mail.gmail.com>
Message-ID: <1466097006.17117.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-06-15 at 09:34 -0700, Venkatesh Srinivas wrote:
> On Wed, Jun 15, 2016 at 6:37 AM, Paolo Abeni <pabeni@redhat.com>
> wrote:
> > 
> > Currently the function ixgbe_poll() returns 0 when it clean
> > completely
> > the rx rings, but this foul budget accounting in core code.
> > Fix this returning the actual work done, capped to weight - 1,
> > since
> > the core doesn't allow to return the full budget when the driver
> > modifies
> > the napi status
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
> > ?1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 088c47c..8bebd86 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -2887,7 +2887,7 @@ int ixgbe_poll(struct napi_struct *napi, int
> > budget)
> > ????????if (!test_bit(__IXGBE_DOWN, &adapter->state))
> > ????????????????ixgbe_irq_enable_queues(adapter, BIT_ULL(q_vector-
> > >v_idx));
> > 
> > -???????return 0;
> > +???????return min(work_done, budget - 1);
> > ?}
> > 
> > ?/**
> Reviewed-by: Venkatesh Srinivas <venkateshs@google.com>
> 
> The same bit of code appears in fm10k and i40e/i40evf. ixgb appears
> to
> correctly return work_done.
> 
> ixgbe_poll also appears to return an (minor) incorrect work_done in
> another case, BTW. It divides its
> budget between Rx rings associated with a vector. If any ring exceeds
> its share of the budget, ixgbe_poll
> claims to have consumed the full budget, even if a full budget of
> frames was not received in a single
> pass.
> 
> -- vs;

I can submit a patch for fm10k.

Thanks,
Jake
