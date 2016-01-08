From: John Stultz <john.stultz@linaro.org>
Date: Thu, 7 Jan 2016 17:12:16 -0800
Subject: [Intel-wired-lan] [RFC v5 3/6] Add history to cross timestamp
 interface supporting slower devices
In-Reply-To: <op.yawaqe0i1774gr@chall-mobl2.amr.corp.intel.com>
References: <1451911523-8534-1-git-send-email-christopher.s.hall@intel.com>
 <1451911523-8534-4-git-send-email-christopher.s.hall@intel.com>
 <CALAqxLVACLP1_PGWh5Ha9P6DT+HfDu9vg-B5NCShuFvNu21WUQ@mail.gmail.com>
 <op.yawaqe0i1774gr@chall-mobl2.amr.corp.intel.com>
Message-ID: <CALAqxLXphoiigM2Bk9GTJaOYM_F3BGW==cmNiuHSP1dBR56AbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 7, 2016 at 5:07 PM, Christopher Hall
<christopher.s.hall@intel.com> wrote:
> On Wed, 06 Jan 2016 11:37:23 -0800, John Stultz <john.stultz@linaro.org>
> wrote:
>> On Mon, Jan 4, 2016 at 4:45 AM, Christopher S. Hall
>>>
>>> +               if (!history_ref || history_ref->cs_seq != cs_seq ||
>>
>>
>> I've not done a super close reading here. But is it very likely the
>> the history_ref->cs_seq is the same as the captured seq? I thought
>> this history_ref was to allow old cross stamps to be used to improve
>> the back-calculation of the time at the given cycle value. So throwing
>> them out if they are older then the last tick seems strange.
>
>
> Maybe this needs more explanation. The clocksource sequence (cs_seq) is
> incremented for each change in clocksource. I use this to detect a rare
> corner case where the clocksource is changed from (on x86 anyway) TSC and
> then back. If the history crosses one of these changes then interpolation
> shouldn't be attempted (return error). It's not really enough when using the
> history to just check that the current clocksource is equal to the one used
> at the start of the history. The clocksource must not have changed at all.
> To answer your question, it's not at all likely that this would occur.

Yes. Apologies. I had mis-skimmed the cs_seq increment as happening in
the update_wall_time not setup_internals.

Instead of cs_seq, which is easily confused as being related to the
seqcount lock, could you instead call it something more explicit like
clocksource_changed_count?

And yea, having it as part of the timekeeper structure would be the
better place for it.

thanks
-john
