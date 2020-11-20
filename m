From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 20 Nov 2020 06:16:21 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <87wnyi2o1e.fsf@intel.com>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com>
 <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com>
 <20201118125451.GC23320@hoboy.vegasvil.org>
 <87wnyi2o1e.fsf@intel.com>
Message-ID: <20201120141621.GC7027@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 18, 2020 at 04:22:37PM -0800, Vinicius Costa Gomes wrote:

> Talking with the hardware folks, they recommended using the periodic
> method, the one shot method was implemented as a debug/evaluation aid.

I'm guessing ...

The HW generates pairs of time stamps, right?

And these land in the device driver by means of an interrupt, right?

If that is so, then maybe the best way to expose the pair to user
space is to have a readable character device, like we have for the
PTP_EXTTS_REQUEST2.  The ioctl to enable reporting could also set the
message rate.

Although it will be a bit clunky, it looks like we have reserved room
enough for a second, eight-byte time stamp.


	struct ptp_clock_time {
		__s64 sec;  /* seconds */
		__u32 nsec; /* nanoseconds */
		__u32 reserved;
// four here
	};

	struct ptp_extts_event {
		struct ptp_clock_time t; /* Time event occured. */
		unsigned int index;      /* Which channel produced the event. */
		unsigned int flags;      /* Reserved for future use. */
		unsigned int rsv[2];     /* Reserved for future use. */
// eight here
	};


You could set 'flags' to mark this as a time stamp pair, and then
stuff the system time stamp into rsv[2].

Thoughts?

Richard


