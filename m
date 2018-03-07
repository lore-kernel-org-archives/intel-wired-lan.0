From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 6 Mar 2018 21:24:11 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <1520391209.109662.33.camel@gmail.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
Message-ID: <20180307052410.m2yqmokrivjlwcjz@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 06, 2018 at 06:53:29PM -0800, Eric Dumazet wrote:
> This is adding 32+1 bits to sk_buff, and possibly holes in this very
> very hot (and already too fat) structure.
> 
> Do we really need 32 bits for a clockid_t ?

Probably we can live with fewer bits.

For clock IDs with a positive sign, the max possible clock value is 16.

For clock IDs with a negative sign, IIRC, three bits are for the type
code (we have also posix timers packed like this) and the are for the
file descriptor.  So maybe we could use 16 bits, allowing 12 bits or
so for encoding the FD.

The downside would be that this forces the application to make sure
and open the dynamic posix clock early enough before the FD count gets
too high.

Thanks,
Richard
