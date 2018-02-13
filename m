From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue, 13 Feb 2018 10:56:52 +0100
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <d30c45f7-0091-3701-4ffe-3bc712f6436b@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
 <d30c45f7-0091-3701-4ffe-3bc712f6436b@intel.com>
Message-ID: <20180213095652.GA11459@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 12, 2018 at 02:39:06PM -0800, Jesus Sanchez-Palencia wrote:
> On 01/18/2018 12:42 AM, Miroslav Lichvar wrote:
> > Please keep in mind that the PHCs and the system clock don't have to
> > be synchronized to each other. If I understand the rest of the series
> > correctly, there is an assumption that the PHCs are keeping time in
> > TAI and CLOCK_TAI can be used as a fallback.
> 
> Just to double-check, imagine that I've configured the qdisc for
> SW best-effort and with clockid CLOCK_REALTIME. When it receives a
> packet with the clockid of a /dev/ptpX, the qdisc should just drop that
> packet, right?

Yes, I think it should drop it. The kernel does not know the offset
between the two clocks (they don't even have to be synchronized), so
it cannot convert a PHC-based TX time to the system time.

-- 
Miroslav Lichvar
