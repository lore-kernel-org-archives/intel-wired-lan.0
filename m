From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Thu, 18 Jan 2018 09:42:27 +0100
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
Message-ID: <20180118084227.GL1175@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 17, 2018 at 03:06:12PM -0800, Jesus Sanchez-Palencia wrote:
> From: Richard Cochran <rcochran@linutronix.de>
> 
> This patch introduces SO_TXTIME.  User space enables this option in
> order to pass a desired future transmit time in a CMSG when calling
> sendmsg(2).
> 
> A new field is added to struct sockcm_cookie, and the tstamp from
> skbuffs will be used later on.

In the discussion about the v1 patchset, there was a question if the
cmsg should include a clockid_t. Without that, how can an application
prevent the packet from being sent using an incorrect clock, e.g.
the system clock when it expects it to be a PHC, or a different PHC
when the socket is not bound to a specific interface?

At least in some applications it would be preferred to not sent a
packet at all instead of sending it at a wrong time.

Please keep in mind that the PHCs and the system clock don't have to
be synchronized to each other. If I understand the rest of the series
correctly, there is an assumption that the PHCs are keeping time in
TAI and CLOCK_TAI can be used as a fallback.

-- 
Miroslav Lichvar
