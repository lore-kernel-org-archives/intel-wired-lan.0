From: Christopher Hall <christopher.s.hall@intel.com>
Date: Wed, 06 Jan 2016 17:42:53 -0800
Subject: [Intel-wired-lan] [RFC v5 5/6] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <20160105152731.GA24372@netboy>
References: <1451911523-8534-1-git-send-email-christopher.s.hall@intel.com>
 <1451911523-8534-6-git-send-email-christopher.s.hall@intel.com>
 <20160105152731.GA24372@netboy>
Message-ID: <op.yauhpruq1774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

This all sounds fine.  Thanks for the feedback.  I'll roll this into the  
next patchset.

Chris

On Tue, 05 Jan 2016 07:27:32 -0800, Richard Cochran  
<richardcochran@gmail.com> wrote:
> On Mon, Jan 04, 2016 at 04:45:22AM -0800, Christopher S. Hall wrote:
>> +	case PTP_SYS_OFFSET_PRECISE:
>> +		if (!ptp->info->getsynctime) {
>> +			err = -EINVAL;
>
> -EOPNOTSUPP would be better here.
>
>> +		precise_offset.sys_real.sec =
>> +			div_u64_rem(ktime_to_ns(xtstamp.sys_realtime),
>> +				    NSEC_PER_SEC, &rem);
>> +		precise_offset.sys_real.nsec = rem;
>
> How about this instead:
>
> 		ts = ktime_to_timespec64(xtstamp.sys_realtime);
> 		precise_offset.sys_real.sec = ts.tv_sec;
> 		precise_offset.sys_real.nsec = ts.tv_nsec;
>
>> +		precise_offset.sys_raw.sec =
>> +			div_u64_rem(ktime_to_ns(xtstamp.sys_monoraw),
>> +				    NSEC_PER_SEC, &rem);
>> +		precise_offset.sys_raw.nsec = rem;
>> +		precise_offset.dev.sec =
>> +			div_u64_rem(ktime_to_ns(xtstamp.device), NSEC_PER_SEC,
>> +				    &rem);
>> +		precise_offset.dev.nsec = rem;
>
> And for these as well.
>
> Thanks,
> Richard
