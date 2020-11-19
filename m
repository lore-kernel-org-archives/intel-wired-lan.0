From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 18 Nov 2020 16:22:37 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201118125451.GC23320@hoboy.vegasvil.org>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com> <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com> <20201118125451.GC23320@hoboy.vegasvil.org>
Message-ID: <87wnyi2o1e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> On Tue, Nov 17, 2020 at 05:21:48PM -0800, Vinicius Costa Gomes wrote:
>> Agreed that would be easiest/simplest. But what I have in hand seems to
>> not like it, i.e. I have an earlier series implementing this "one shot" way
>> and it's not reliable over long periods of time or against having the
>> system time adjusted.
>
> Before we go inventing a new API, I think we should first understand
> why the one shot thing fails.

Talking with the hardware folks, they recommended using the periodic
method, the one shot method was implemented as a debug/evaluation aid.

The explanation I have is something along these lines: the hardware
keeps track of the "delta" between the Master Time and its own clock,
and uses it to calculate the timestamps exposed in the NIC registers. To
have a better "delta" it needs more samples. And so it has improved
stability when PTM dialogs happen more continuously, and that's the
recommended way.

The PCIe PTM specification doesn't suggest how the timestamps need to be
exposed/calculated, and how long it needs to run, and it sounded to me
that other implementations could have similar behavior.

>
> If there is problem with the system time being adjusted during PTM,
> then that needs solving in any case!

When PTM is running in the periodic mode, system clock adjustments are
handled fine.


Cheers,
-- 
Vinicius
