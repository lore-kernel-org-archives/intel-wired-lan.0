From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Fri, 23 Oct 2020 09:45:53 -0400
Subject: [Intel-wired-lan] [PATCH v4 2/4] sched/isolation: Extend
 nohz_full to isolate managed IRQs
In-Reply-To: <20201023132505.GZ2628@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-3-nitesh@redhat.com>
 <20201023132505.GZ2628@hirez.programming.kicks-ass.net>
Message-ID: <ef8fbae8-06e1-b947-30b1-281afd330f01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/23/20 9:25 AM, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 02:35:27PM -0400, Nitesh Narayan Lal wrote:
>> Extend nohz_full feature set to include isolation from managed IRQS. This
> So you say it's for managed-irqs, the feature is actually called
> MANAGED_IRQ, but, AFAICT, it does *NOT* in fact affect managed IRQs.

Ah my bad! I should replace the managed IRQS with MANAGED_IRQ.
I can send another version with this fixed.

>
> Also, as per Thomas' earlier points, managed-irqs are in fact perfectly
> fine and don't need help at at...

Since the introduction of
"genirq, sched/isolation: Isolate from handling managed interrupts"

Within irq_do_set_affinity(), it is ensured that for managed intrrupts as
well, the isolated CPUs are removed from the affinity mask.

Hence, IMHO before this change managed interrupts were affecting the
isolated CPUs.

My intent of having this change is to basically allow isolation for
nohz_full CPUs even when we don't have something like isolcpus.
Does that make sense?


>
>> is required specifically for setups that only uses nohz_full and still
>> requires isolation for maintaining lower latency for the listed CPUs.
>>
>> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  kernel/sched/isolation.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 5a6ea03f9882..9df9598a9e39 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -141,7 +141,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>>  	unsigned int flags;
>>  
>>  	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
>> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
>> +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_MANAGED_IRQ;
>>  
>>  	return housekeeping_setup(str, flags);
>>  }
>> -- 
>> 2.18.2
>>
-- 
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201023/0559be1a/attachment-0001.asc>
