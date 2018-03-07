From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 07 Mar 2018 14:45:45 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <b612233d-cad6-9fb3-0d08-763bc25553c1@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <b612233d-cad6-9fb3-0d08-763bc25553c1@intel.com>
Message-ID: <1520462745.109662.59.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-03-07 at 13:52 -0800, Jesus Sanchez-Palencia wrote:
> Hi,
...
> I should have mentioned on the commit msg, but the tc_drop_if_late is
> actually
> filling a 1 bit hole that was already there.
> 
> 
> > 
> > Do we really need 32 bits for a clockid_t ?
> 
> There is a 2 bytes hole just after tc_index, so a u16 clockid would
> fit
> perfectly without increasing the skbuffs size / cachelines any
> further.
> 
> From Richard's reply, it seems safe to just change the definition
> here if we
> make it explicit on the SCM_CLOCKID documentation the caveat about
> the max
> possible fd count for dynamic clocks.
> 
> How does that sound?

Not convincing really :/

Next big feature needing one bit in sk_buff will add it, and add a
63bit hole.

Then next feature(s) will happily consume 'because there are holes
anyway'.

Then at some point we will cross cache line boundary and performance
will take a 10 % hit.

It is a never ending trend.

If you really need 33 bits, then maybe we'll ask you to guard the new
bits with some #if IS_ENABLED(CONFIG_...) so that we can opt-out.

Why do we _really_ need dynamic clocks being supported in core
networking stack, other than 'that is needed to send 2 packets per
second with precise departure time and arbitrary user defined clocks,
so lets do that, and do not care of the other 10,000,000 packets we
receive/send per second'

I have one patch (TXCS, something that I called XPS in the past)
implementing the remote-freeing of skbs that help workloads where skb
are produced on cpu A and consumed on cpu B,
using an additional 16bit field that I have not upstreamed yet (even if
Mellanox folks want that), simply because of this additional field...

Maybe I should eat this hole before you take it ?

No, we need to be extra careful.

