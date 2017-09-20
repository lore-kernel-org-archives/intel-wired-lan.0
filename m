From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 20 Sep 2017 07:56:16 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170920015911.18999-1-levipearson@gmail.com>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170920015911.18999-1-levipearson@gmail.com>
Message-ID: <20170920055616.snd6tndvbdnesnck@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 19, 2017 at 07:59:11PM -0600, levipearson at gmail.com wrote:
> If some endpoint device shows up with direct Qbv support, this interface would
> probably work well there too, although a talker would need to be able to
> schedule its transmits pretty precisely to achieve the lowest possible latency.

This is an argument for SO_TXTIME.

> One concern here is calling the base-time parameter an interval; it's really
> an absolute time with respect to the PTP timescale. Good documentation will
> be important to this one, since the specification discusses some subtleties
> regarding the impact of different time values chosen here.
> 
> The format for specifying the actual intervals such as cycle-time could prove
> to be an important detail as well; Qbv specifies cycle-time as a ratio of two
> integers expressed in seconds, while extension-time is specified as an integer
> number of nanoseconds.
> 
> Precision with the cycle-time is especially important, since base-time can be
> almost arbitrarily far in the past or future, and any given cycle start should
> be calculable from the base-time plus/minus some integer multiple of cycle-
> time.

The above three points also.

Thanks,
Richard
