From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 22 Mar 2021 08:36:26 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201118125451.GC23320@hoboy.vegasvil.org>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com> <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com> <20201118125451.GC23320@hoboy.vegasvil.org>
Message-ID: <87czvrkxol.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Richard Cochran <richardcochran@gmail.com> writes:

> On Tue, Nov 17, 2020 at 05:21:48PM -0800, Vinicius Costa Gomes wrote:
>> Agreed that would be easiest/simplest. But what I have in hand seems to
>> not like it, i.e. I have an earlier series implementing this "one shot" way
>> and it's not reliable over long periods of time or against having the
>> system time adjusted.
>
> Before we go inventing a new API, I think we should first understand
> why the one shot thing fails.

After a long time, a couple of internal misunderstandings, fixing some
typos in the delay adjustment constants and better error handling, this
one shot method is working well.

I will propose a new version, implementing PTP_SYS_OFFSET_PRECISE using
the one shot way.

>
> If there is problem with the system time being adjusted during PTM,
> then that needs solving in any case!

The new series uses shorter cycles, is able to restart the PTM dialogs
if an error is detected (the clock adjustment in the end causes the NIC
to report a PTM timeout), so things are working better.

>
> Thanks,
> Richard


Cheers,
-- 
Vinicius
