From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 24 Sep 2020 17:52:19 -0400
Subject: [Intel-wired-lan] [PATCH v2 1/4] sched/isolation: API to get
 housekeeping online CPUs
In-Reply-To: <20200924204759.GA2342589@bjorn-Precision-5520>
References: <20200924204759.GA2342589@bjorn-Precision-5520>
Message-ID: <c19c4bc8-05d4-42a2-9469-2de79919c808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 9/24/20 4:47 PM, Bjorn Helgaas wrote:
> On Wed, Sep 23, 2020 at 02:11:23PM -0400, Nitesh Narayan Lal wrote:
>> Introduce a new API hk_num_online_cpus(), that can be used to
>> retrieve the number of online housekeeping CPUs that are meant to handle
>> managed IRQ jobs.
>>
>> This API is introduced for the drivers that were previously relying only
>> on num_online_cpus() to determine the number of MSIX vectors to create.
>> In an RT environment with large isolated but fewer housekeeping CPUs this
>> was leading to a situation where an attempt to move all of the vectors
>> corresponding to isolated CPUs to housekeeping CPUs were failing due to
>> per CPU vector limit.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  include/linux/sched/isolation.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>> index cc9f393e2a70..2e96b626e02e 100644
>> --- a/include/linux/sched/isolation.h
>> +++ b/include/linux/sched/isolation.h
>> @@ -57,4 +57,17 @@ static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
>>  	return true;
>>  }
>>  
>> +static inline unsigned int hk_num_online_cpus(void)
>> +{
>> +#ifdef CONFIG_CPU_ISOLATION
>> +	const struct cpumask *hk_mask;
>> +
>> +	if (static_branch_unlikely(&housekeeping_overridden)) {
>> +		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
>> +		return cpumask_weight(hk_mask);
>> +	}
>> +#endif
>> +	return cpumask_weight(cpu_online_mask);
> Just curious: why is this not
>
>   #ifdef CONFIG_CPU_ISOLATION
>   ...
>   #endif
>     return num_online_cpus();

I think doing an atomic read is better than a bitmap operation.
Thanks for pointing this out.

>
>> +}
>> +
>>  #endif /* _LINUX_SCHED_ISOLATION_H */
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200924/45fdf978/attachment-0001.asc>
