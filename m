From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 27 Mar 2018 17:12:49 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C81CD24@ORSMSX101.amr.corp.intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
 <20180322003353.29970-8-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C81BBB3@ORSMSX101.amr.corp.intel.com>
 <87lgeecryc.fsf@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C81CD24@ORSMSX101.amr.corp.intel.com>
Message-ID: <87h8p1awhq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

[...]

> And watching the rx_queue counters continues to be spread across the different queues.  This is with Jeff Kirsher's  next queue, kernel 4.16.0-rc4_next-queue_dev-queue_e31d20a, which has the series of 8 igb patches applied.
>
> When I go back and run the an older build (with an earlier version of
> the series) of the same tree, 4.16.0-rc4_next-queue_dev-queue_84a3942,
> with the same procedure and same systems all the rx traffic is
> relegated to queue 0 (or whichever queue I assign it to) for either
> the src or dst filter.  Here is a sample of my counters after it had
> been running netperf_stress over the weekend:

The difference in behaviour between v4 and v5 is that v4 is configuring
(wrongly) the controller to send all the traffic directed to the
local MAC address to queue 0, v5 allows that filter to be added, but it
does nothing in reality.

I am working on a new version of this series that should work for adding
filters that involve the local MAC address. The initial use cases that I
had in mind all used MAC addresses different from the local one, but I
see that this indeed useful (and less surprising).


Thank you,
--
Vinicius
