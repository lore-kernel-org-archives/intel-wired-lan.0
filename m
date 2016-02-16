From: Christopher Hall <christopher.s.hall@intel.com>
Date: Tue, 16 Feb 2016 10:23:01 -0800
Subject: [Intel-wired-lan] [PATCH v7 3/8] time: Remove duplicated code
 in ktime_get_raw_and_real()
In-Reply-To: <20160216075210.GA2461@localhost.localdomain>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <1455308729-6280-4-git-send-email-christopher.s.hall@intel.com>
 <20160216075210.GA2461@localhost.localdomain>
Message-ID: <op.ycxuonx01774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 15 Feb 2016 23:52:10 -0800, Richard Cochran  
<richardcochran@gmail.com> wrote:
>> @@ -888,6 +888,8 @@ void ktime_get_snapshot(struct system_time_snapshot  
>> *systime_snapshot)
>>  	s64 nsec_real;
>>  	cycle_t now;
>>
>> +	WARN_ON(timekeeping_suspended);
> ...
>> -	WARN_ON_ONCE(timekeeping_suspended);
>
> Is this change intentional?

Yes it is. The code I replaced in pps_kernel.h (pps_get_ts()) has two call  
paths depending on whether CONFIG_NTP_PPS is set. On one call path  
(realtime only, config unset) WARN_ON(), from getnstimeofday64, is used,  
on the other WARN_ON_ONCE(), from ktime_get_raw_and_real_ts64(), is used.  
I opted for the greater verbosity of the two when I combined the code.

Is WARN_ON_ONCE() better here?

Thanks,
Chris
