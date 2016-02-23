From: Christopher Hall <christopher.s.hall@intel.com>
Date: Mon, 22 Feb 2016 18:38:11 -0800
Subject: [Intel-wired-lan] [PATCH v7 6/8] x86: tsc: Always Running Timer
 (ART) correlated clocksource
In-Reply-To: <56C63385.9050703@kernel.org>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <1455308729-6280-7-git-send-email-christopher.s.hall@intel.com>
 <56C63385.9050703@kernel.org>
Message-ID: <op.yc9llxxf1774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 18 Feb 2016 13:11:33 -0800, Andy Lutomirski <luto@kernel.org>  
wrote:
>> +#define X86_FEATURE_INVARIANT_TSC (7*32+4) /* Intel Invariant TSC */

This is removed. It was basically an alias for NONSTOP_TSC and not needed.

>
>> +/*
>> + * Convert ART to TSC given numerator/denominator found in detect_art()
>> + */
>> +struct system_counterval_t convert_art_to_tsc(cycle_t art)
>> +{
>> +	u64 tmp, res, rem;
>> +
>> +	rem = do_div(art, art_to_tsc_denominator);
>> +
>> +	res = art * art_to_tsc_numerator;
>> +	tmp = rem * art_to_tsc_numerator;
>> +
>> +	do_div(tmp, art_to_tsc_denominator);
>> +	res += tmp;
>> +
>> +	return (struct system_counterval_t) {.cs = art_related_clocksource,
>> +			.cycles = res};
>
> The SDM and the patch description both mention an offset "k".  Shouldn't  
> this code at least have a comment about how it deals with the k != 0  
> case?

I don't deal with the k != 0 case. I assume that IA32 TSC adjust MSR is 0  
because it's almost always a *bad idea* to change it. I've discussed this  
with a few other developers and there is some consensus agreeing. From an  
earlier related thread Peter Zijlstra asserts that TSC adjust "had
better" be 0.(http://lkml.iu.edu/hypermail/linux/kernel/1507.3/03734.html).

Do we really need to accommodate BIOS's that do this?

Chris
