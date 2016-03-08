From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Mar 2016 11:58:37 -0800
Subject: [Intel-wired-lan] [PATCH 2/5] i40e/i40evf: Add support for bulk
 free in Tx cleanup
In-Reply-To: <20160308113919.000012c8@unknown>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173003.5682.90872.stgit@localhost.localdomain>
 <20160308113919.000012c8@unknown>
Message-ID: <CAKgT0UfBw4mOan8oaKiWatUs_WtmxCjKKOJeMLEGBoAXg0ca3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 8, 2016 at 11:39 AM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> Thanks Alex, one comment below.
>
> On Mon, 7 Mar 2016 09:30:03 -0800
> Alexander Duyck <aduyck@mirantis.com> wrote:
>> @@ -1975,7 +1977,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>>        * budget and be more aggressive about cleaning up the Tx descriptors.
>>        */
>>       i40e_for_each_ring(ring, q_vector->tx) {
>> -             if (!i40e_clean_tx_irq(ring, vsi->work_limit)) {
>> +             if (!i40e_clean_tx_irq(vsi, ring, budget)) {
>>                       clean_complete = false;
>>                       continue;
>>               }
>
> I'm not sure if this was a search/replace miss or if you intended it,
> but I believe that limiting our transmit cleanup work in i40e_napi_poll
> to budget is wrong, as transmit cleanup is so cheap compared to rx,
> that we typically don't need to limit it to 64 skbs cleaned.  We can't
> just have it clean unlimited numbers, so we put in a work limit that is
> adjustable via ethtool and defaults to half the ring size.
>
> So this change
> 1) breaks the ethtool adjustment of tx work_limit, and
> 2) significantly decreases the number of transmits we will clean per
> poll loop.

Please re-read the patch.  You notice I am passing the VSI as the
first argument.  That is how I am still acquiring the budget as it is
pulled from the vsi.

The value passed in the last parameter is the NAPI budget.  The NAPI
budget value is being passed as it is needed by the napi_consume_skb
call in order to determine if we were called with a budget of 0 or
not.  If we were that indicates this is actually a netpoll call, if it
is non-zero then it indicates we are a standard NAPI call.

- Alex
