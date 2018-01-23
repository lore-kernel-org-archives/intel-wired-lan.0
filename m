From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 23 Jan 2018 13:22:37 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180118084227.GL1175@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
Message-ID: <877es81d9e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Miroslav Lichvar <mlichvar@redhat.com> writes:

> On Wed, Jan 17, 2018 at 03:06:12PM -0800, Jesus Sanchez-Palencia wrote:
>> From: Richard Cochran <rcochran@linutronix.de>
>> 
>> This patch introduces SO_TXTIME.  User space enables this option in
>> order to pass a desired future transmit time in a CMSG when calling
>> sendmsg(2).
>> 
>> A new field is added to struct sockcm_cookie, and the tstamp from
>> skbuffs will be used later on.
>
> In the discussion about the v1 patchset, there was a question if the
> cmsg should include a clockid_t. Without that, how can an application
> prevent the packet from being sent using an incorrect clock, e.g.
> the system clock when it expects it to be a PHC, or a different PHC
> when the socket is not bound to a specific interface?
>
> At least in some applications it would be preferred to not sent a
> packet at all instead of sending it at a wrong time.

Including the clockid in a CMSG field does make sense. Will add it in
the next version of this series.

What I think would be the ideal scenario would be if the clockid
parameter to the TBS Qdisc would not be necessary (if offload was
enabled), but that's not quite possible right now, because there's no
support for using the hrtimer infrastructure with dynamic clocks
(/dev/ptp*).

What I am thinking is to keep the clockid parameter for the Qdisc (and
add support for expressing the clockid in friendlier ways, as requested
later in this thread), but I can't think of a way to add support for
using /dev/ptp* clocks without first having hrtimer support them.

And the behavior would be to drop any packets with a clockid not
matching the Qdisc clockid.

How does this sound?


>
> Please keep in mind that the PHCs and the system clock don't have to
> be synchronized to each other. If I understand the rest of the series
> correctly, there is an assumption that the PHCs are keeping time in
> TAI and CLOCK_TAI can be used as a fallback.

You understand correctly, that's because of whole hrtimer issue.

>
> -- 
> Miroslav Lichvar


Cheers,
--
Vinicius
