From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 23 Apr 2015 11:19:01 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Pull timestamp from fragment
 before adding it to skb
In-Reply-To: <CAM_iQpVyQoGZZByC1n3sAP0Txyf7H60WnKdNCBX+K0s8Wezscw@mail.gmail.com>
References: <CAM_iQpVyQoGZZByC1n3sAP0Txyf7H60WnKdNCBX+K0s8Wezscw@mail.gmail.com>
Message-ID: <55393795.6000000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/23/2015 10:10 AM, Cong Wang wrote:
> On Wed, Apr 22, 2015 at 9:49 PM, Alexander Duyck
> <alexander.h.duyck@redhat.com> wrote:
>> This change makes it so that we pull the timestamp from the fragment before
>> we add it to the skb.  By doing this we can avoid a possible issue in which
>> the fragment can possibly be less than IGB_RX_HDR_LEN due to the timestamp
>> being pulled after the copybreak check.
>
> You said the first frag is always 2K if it exists. If this is not true, then
> my patch is needed too.

I said the first fragment is always 2K if a secondary frag exists.  We
always reserve 2K for each buffer so the memory is there and could be
read, it just wouldn't contain valid header data once you get past the
size reported by the Rx descriptor.

The issue is the data_len can get mangled due to the 16 bytes for the
timestamp being unaccounted for.  The goal was to fix this and not
introduce any other vulnerabilities or performance regressions which was
my concern with your patch.  I would prefer to err on the side of
parsing fewer bytes than possibly parsing a full frame if someone
decided to submit one that was nothing but tunnel headers for instance.

>> While making this change I realized we could also pull the rest of the
>> igb_pull_tail function into igb_add_rx_frag since in the case of igb,
>> unlike ixgbe, we are able to unmap the entire buffer before calling
>> add_rx_frag so merging the two allows for sharing of code between the two
>> merged functions.
> Can you make a simple change for stable? Of course unless this
> patch is targeted for net-next, but $subject doesn't say so.

I assume net-next since that is where most of the changes on this list
are submitted to.

> Also, please Cc netdev, I am not on intel-wired-lan list.

I'll try to remember that for next time.

> BTW, it would be nice to Cc me for all 3 patches, as they might
> be related for review.

I honestly don't think this is worth the effort to backport to stable. 
If you really feel the need your best bet would probably be to just
modify the eth_get_headlen line and pass it IGB_RX_HDR_LEN -
IGB_TS_HDR_LEN, then you would be guaranteed that the issue cannot occur
and still should be able to get a reasonable header size pulled in.  The
fact is this is an extreme corner case and the odds are extremely low of
anyone ever encountering it.

- Alex
