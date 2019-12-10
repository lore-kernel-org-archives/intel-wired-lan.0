From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Tue, 10 Dec 2019 14:26:44 +0000
Subject: [Intel-wired-lan] [PATCH bpf 3/4] net/i40e: Fix concurrency
 issues between config flow and XSK
In-Reply-To: <CAJ+HfNiXPo_Qkja=tCakX6a=swVY_KRMXmT79wQuQa_+kORQ=g@mail.gmail.com>
References: <20191205155028.28854-1-maximmi@mellanox.com>
 <20191205155028.28854-4-maximmi@mellanox.com>
 <CAJ+HfNiXPo_Qkja=tCakX6a=swVY_KRMXmT79wQuQa_+kORQ=g@mail.gmail.com>
Message-ID: <121c3135-3b52-1d64-c1e0-26de38687b4f@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-12-06 11:03, Bj?rn T?pel wrote:
> On Thu, 5 Dec 2019 at 16:52, Maxim Mikityanskiy <maximmi@mellanox.com> wrote:
>>
>> Use synchronize_rcu to wait until the XSK wakeup function finishes
>> before destroying the resources it uses:
>>
>> 1. i40e_down already calls synchronize_rcu. On i40e_down either
>> __I40E_VSI_DOWN or __I40E_CONFIG_BUSY is set. Check the latter in
>> i40e_xsk_async_xmit (the former is already checked there).
>>
>> 2. After switching the XDP program, call synchronize_rcu to let
>> i40e_xsk_async_xmit exit before the XDP program is freed.
>>
>> 3. Changing the number of channels brings the interface down (see
>> i40e_prep_for_reset and i40e_pf_quiesce_all_vsi).
>>
>> 4. Disabling UMEM sets __I40E_CONFIG_BUSY, too.
>>
>> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
>>   drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 4 ++++
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 1ccabeafa44c..afa3a99e68e1 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -6823,8 +6823,8 @@ void i40e_down(struct i40e_vsi *vsi)
>>          for (i = 0; i < vsi->num_queue_pairs; i++) {
>>                  i40e_clean_tx_ring(vsi->tx_rings[i]);
>>                  if (i40e_enabled_xdp_vsi(vsi)) {
>> -                       /* Make sure that in-progress ndo_xdp_xmit
>> -                        * calls are completed.
>> +                       /* Make sure that in-progress ndo_xdp_xmit and
>> +                        * ndo_xsk_async_xmit calls are completed.

Ooops, I see now some changes were lost during rebasing. I had a version 
of this series with ndo_xsk_async_xmit -> ndo_xsk_wakeup fixed.

>>                           */
>>                          synchronize_rcu();
>>                          i40e_clean_tx_ring(vsi->xdp_rings[i]);
>> @@ -12545,6 +12545,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
>>                  i40e_prep_for_reset(pf, true);
>>
>>          old_prog = xchg(&vsi->xdp_prog, prog);
>> +       if (old_prog)
>> +               /* Wait until ndo_xsk_async_xmit completes. */
>> +               synchronize_rcu();
> 
> This is not needed -- please correct me if I'm missing something! If
> we're disabling XDP, the need_reset-clause will take care or the
> proper synchronization.

Yes, it was added to cover the case of disabling XDP. I'm not sure how 
i40e_reset_and_rebuild will help here. What I wanted to achieve is to 
wait until all i40e_xsk_wakeups finish after setting vsi->xdp_prog = 
NULL and before doing anything else. I don't see how 
i40e_reset_and_rebuild helps here, but I'm not very familiar with i40e 
code. Could you guide me through the code of i40e_reset_and_rebuild and 
show how it takes care of the synchronization?

> And we don't need to worry about old_prog for
> the swap-XDP case,

Right.

> because bpf_prog_put() does cleanup with
> call_rcu().

But if i40e_xsk_wakeup is not wrapped with rcu_read_lock, it won't sync 
with it.

> 
>>
>>          if (need_reset)
>>                  i40e_reset_and_rebuild(pf, true, true);
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> index d07e1a890428..f73cd917c44f 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> @@ -787,8 +787,12 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>>   {
>>          struct i40e_netdev_priv *np = netdev_priv(dev);
>>          struct i40e_vsi *vsi = np->vsi;
>> +       struct i40e_pf *pf = vsi->back;
>>          struct i40e_ring *ring;
>>
>> +       if (test_bit(__I40E_CONFIG_BUSY, pf->state))
>> +               return -ENETDOWN;
>> +
> 
> You right that we need to check for BUSY, since the XDP ring might be
> stale! Thanks for catching this! Can you respin this patch, with just
> this hunk? (Unless I'm wrong! :-))

This check itself will not be enough, unless you wrap i40e_xsk_wakeup 
with rcu_read_lock.

i40e_xsk_wakeup does some checks in the beginning, then the main part of 
the code goes. My assumption is that if the checks don't pass, the main 
part will fail in some way (e.g., NULL or dangling pointer when 
accessing the ring), otherwise you wouldn't need those checks at all. 
Without RCU, even if you do these checks, it may still fail in the 
following scenario:

1. i40e_xsk_wakeup starts running, checks the flag, the flag is set, the 
function goes on.

2. The flag gets cleared.

3. The resources are destroyed.

4. i40e_xsk_wakeup tries to access the resources that were destroyed.

I don't see anything in i40e and ixgbe that currently protects from such 
a race condition. If I'm missing anything, please point me to it, 
otherwise i40e_xsk_wakeup really needs to be wrapped into rcu_read_lock. 
I would prefer to have rcu_read_lock in the kernel, so that all drivers 
could benefit from it, because I think it's the same issue in all 
drivers, but I'm fine with moving it to the drivers if there is a reason 
why some drivers may not need it.

Thanks for taking a look. Let's settle the case with Intel's drivers, so 
that I will know what fixes to include into the respin.

> 
> 
>>          if (test_bit(__I40E_VSI_DOWN, vsi->state))
>>                  return -ENETDOWN;
>>
>> --
>> 2.20.1
>>

