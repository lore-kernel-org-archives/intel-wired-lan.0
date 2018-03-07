From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 7 Mar 2018 09:35:24 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <CAF=yD-J+3y_RNiW791eW+5i=6Op_0jmM1G8fHiKuKXDqtb8XjA@mail.gmail.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <20180307052410.m2yqmokrivjlwcjz@localhost>
 <CAF=yD-J+3y_RNiW791eW+5i=6Op_0jmM1G8fHiKuKXDqtb8XjA@mail.gmail.com>
Message-ID: <20180307173524.i6mpg3f2rjnwl3xe@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 07, 2018 at 12:01:19PM -0500, Willem de Bruijn wrote:
> The same choices are probably made for all packets on a given
> socket. Unless skb->sk gets scrubbed in some transmit paths,
> then these be set as sockopt instead of cmsg.

The discussion on v2 ended with this per-message idea, in preference
to the per-socket idea, IIRC.

Thanks,
Richard
