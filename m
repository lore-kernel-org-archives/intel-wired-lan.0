From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 19 Jun 2019 16:54:32 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 4/6] taprio: Add support
 for txtime-assist mode.
In-Reply-To: <20190617.162245.717911211395007022.davem@davemloft.net>
References: <1560799870-18956-1-git-send-email-vedang.patel@intel.com>
 <1560799870-18956-5-git-send-email-vedang.patel@intel.com>
 <20190617.162245.717911211395007022.davem@davemloft.net>
Message-ID: <0EE3B2CB-5EEA-47B5-B90D-A74177A04570@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks for the input David. 


> On Jun 17, 2019, at 4:22 PM, David Miller <davem@davemloft.net> wrote:
> 
> From: Vedang Patel <vedang.patel@intel.com>
> Date: Mon, 17 Jun 2019 12:31:08 -0700
> 
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index a41d7d4434ee..ab6080013666 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
> ...
>> +/* Get how much time has been already elapsed in the current cycle. */
>> +static inline s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
>> +{
> 
> Please do not use the inline directive in foo.c files, let the compiler decide.
> 
Okay, I will remove inline directive from all C files and send a new version.

-Vedang
> ...
>> +static inline int length_to_duration(struct taprio_sched *q, int len)
>> +{
>> +	return (len * atomic64_read(&q->picos_per_byte)) / 1000;
>> +}
> 
> Likewise.
> 
> ...
>> +static inline ktime_t get_cycle_start(struct sched_gate_list *sched,
>> +				      ktime_t time)
>> +{
> 
> Likewise.

