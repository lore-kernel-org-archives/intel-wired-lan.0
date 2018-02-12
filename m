From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Mon, 12 Feb 2018 14:39:06 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180118084227.GL1175@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
Message-ID: <d30c45f7-0091-3701-4ffe-3bc712f6436b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 01/18/2018 12:42 AM, Miroslav Lichvar wrote:
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
> 
> Please keep in mind that the PHCs and the system clock don't have to
> be synchronized to each other. If I understand the rest of the series
> correctly, there is an assumption that the PHCs are keeping time in
> TAI and CLOCK_TAI can be used as a fallback.


Just to double-check, imagine that I've configured the qdisc for
SW best-effort and with clockid CLOCK_REALTIME. When it receives a
packet with the clockid of a /dev/ptpX, the qdisc should just drop that
packet, right?

Or would this block any use-cases that I couldn't think of ?

Thanks,
Jesus
