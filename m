From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Mar 2018 12:01:19 -0500
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <20180307052410.m2yqmokrivjlwcjz@localhost>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <20180307052410.m2yqmokrivjlwcjz@localhost>
Message-ID: <CAF=yD-J+3y_RNiW791eW+5i=6Op_0jmM1G8fHiKuKXDqtb8XjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 7, 2018 at 12:24 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Mar 06, 2018 at 06:53:29PM -0800, Eric Dumazet wrote:
>> This is adding 32+1 bits to sk_buff, and possibly holes in this very
>> very hot (and already too fat) structure.
>>
>> Do we really need 32 bits for a clockid_t ?
>
> Probably we can live with fewer bits.
>
> For clock IDs with a positive sign, the max possible clock value is 16.
>
> For clock IDs with a negative sign, IIRC, three bits are for the type
> code (we have also posix timers packed like this) and the are for the
> file descriptor.  So maybe we could use 16 bits, allowing 12 bits or
> so for encoding the FD.
>
> The downside would be that this forces the application to make sure
> and open the dynamic posix clock early enough before the FD count gets
> too high.

The same choices are probably made for all packets on a given
socket. Unless skb->sk gets scrubbed in some transmit paths,
then these be set as sockopt instead of cmsg.
