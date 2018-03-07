From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Mar 2018 09:47:40 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <20180307173722.hvqorkaiougt4qjm@localhost>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <20180307052410.m2yqmokrivjlwcjz@localhost>
 <CAF=yD-J+3y_RNiW791eW+5i=6Op_0jmM1G8fHiKuKXDqtb8XjA@mail.gmail.com>
 <20180307173524.i6mpg3f2rjnwl3xe@localhost>
 <20180307173722.hvqorkaiougt4qjm@localhost>
Message-ID: <CANn89iJZbepLCr+biMWGeSFvG0ub3tdKfW3ci+75Hz9ndO1M9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 7, 2018 at 9:37 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Wed, Mar 07, 2018 at 09:35:24AM -0800, Richard Cochran wrote:
>> The discussion on v2 ended with this per-message idea, in preference
>> to the per-socket idea, IIRC.
>
> (But my own opinion is that per-socket is good enough...)
>
> Thanks,
> Richard

I would love if skb->tstamp could be either 0 or expressed in
ktime_get() base all the time.

( Even if we would have to convert this to other bases when/if needed)

Having to deal with many clockid in the core networking stack seems
over engineered.
