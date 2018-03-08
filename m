From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Thu, 8 Mar 2018 12:37:22 +0100
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <1520462745.109662.59.camel@gmail.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <b612233d-cad6-9fb3-0d08-763bc25553c1@intel.com>
 <1520462745.109662.59.camel@gmail.com>
Message-ID: <20180308113722.GB28493@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 07, 2018 at 02:45:45PM -0800, Eric Dumazet wrote:
> On Wed, 2018-03-07 at 13:52 -0800, Jesus Sanchez-Palencia wrote:
> > > Do we really need 32 bits for a clockid_t ?
> > 
> > There is a 2 bytes hole just after tc_index, so a u16 clockid would
> > fit
> > perfectly without increasing the skbuffs size / cachelines any
> > further.

> Not convincing really :/
> 
> Next big feature needing one bit in sk_buff will add it, and add a
> 63bit hole.

Would it be possible to put the clockid in skb_shared_info? If that's
technically difficult or does not make sense, I'm ok with the clockid
being a socket option.

If a packet is sent immediately after changing the clockid via
setsockopt(), will it be still guaranteed that the packet is
restricted by the new id?

> Why do we _really_ need dynamic clocks being supported in core
> networking stack, other than 'that is needed to send 2 packets per
> second with precise departure time and arbitrary user defined clocks,
> so lets do that, and do not care of the other 10,000,000 packets we
> receive/send per second'

Well, I'd not expect it to be a common use case, but a public NTP
server could be sending millions of packets per second in traffic
peaks (typically at *:00:00) over multiple interfaces.

-- 
Miroslav Lichvar
