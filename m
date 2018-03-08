From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Thu, 8 Mar 2018 09:56:32 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <20180308164418.f3vmql2kluvattq6@localhost>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <20180307052410.m2yqmokrivjlwcjz@localhost>
 <CAF=yD-J+3y_RNiW791eW+5i=6Op_0jmM1G8fHiKuKXDqtb8XjA@mail.gmail.com>
 <20180307173524.i6mpg3f2rjnwl3xe@localhost>
 <20180307173722.hvqorkaiougt4qjm@localhost>
 <CANn89iJZbepLCr+biMWGeSFvG0ub3tdKfW3ci+75Hz9ndO1M9g@mail.gmail.com>
 <20180308164418.f3vmql2kluvattq6@localhost>
Message-ID: <93793e84-3438-fbd6-867b-b17755f37613@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 03/08/2018 08:44 AM, Richard Cochran wrote:
> On Wed, Mar 07, 2018 at 09:47:40AM -0800, Eric Dumazet wrote:
>> I would love if skb->tstamp could be either 0 or expressed in
>> ktime_get() base all the time.
>>
>> ( Even if we would have to convert this to other bases when/if needed)
> 
> We really do need variable clock IDs.  Otherwise the HW offloading
> case won't work.  The desired transmit time must be expressed in terms
> of the clock inside the MAC.  This clock is not necessarily related to
> the system time at all.
> 
> But in addition to the performance concerns, I think putting this into
> a socket option is the more natural solution.


Ok, so we have it settled for clockid now. Providing it per-socket was what we'd
proposed previously, so this was just an attempt to accommodate all the feedback
we got on the v2 RFC.

What about the tc_drop_if_late bit, though? Would it be acceptable to keep it
per-packet, thus eating the 1-bit hole from skbuff if we would #if guard it
(e.g. with CONFIG_NET_SCH_TBS)?


Thanks,
Jesus
