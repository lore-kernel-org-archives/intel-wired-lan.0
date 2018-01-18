From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 18 Jan 2018 09:18:35 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 06/10] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <30e104db-3c88-b2f7-4494-98b2bece8ca9@mojatatu.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-7-jesus.sanchez-palencia@intel.com>
 <30e104db-3c88-b2f7-4494-98b2bece8ca9@mojatatu.com>
Message-ID: <20180118171835.rzpb5t5ejddl4ye6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 18, 2018 at 08:35:18AM -0500, Jamal Hadi Salim wrote:
> 1) iproute2: Avoid magic numbers like 1 or 11 please; "offload"
> (without 1) and "TAI" will be more human friendly.

Yes, and for the clockid, the program should accept CLOCK_REALTIME or
CLOCK_TAI for the hard coded SYS-V IDs or /dev/ptp0 for dynamic IDs.

Thanks,
Richard
