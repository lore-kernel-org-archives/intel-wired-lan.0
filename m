From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 24 Sep 2020 08:23:29 -0400
Subject: [Intel-wired-lan] [PATCH v2 1/4] sched/isolation: API to get
 housekeeping online CPUs
In-Reply-To: <20200924120956.GA19346@lenoir>
References: <20200923181126.223766-1-nitesh@redhat.com>
 <20200923181126.223766-2-nitesh@redhat.com>
 <20200924084029.GC1362448@hirez.programming.kicks-ass.net>
 <20200924120956.GA19346@lenoir>
Message-ID: <61d6870d-0749-6c89-38d2-49a2b1fbd569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 9/24/20 8:09 AM, Frederic Weisbecker wrote:
> On Thu, Sep 24, 2020 at 10:40:29AM +0200, peterz at infradead.org wrote:
>> On Wed, Sep 23, 2020 at 02:11:23PM -0400, Nitesh Narayan Lal wrote:
>>> Introduce a new API hk_num_online_cpus(), that can be used to
>>> retrieve the number of online housekeeping CPUs that are meant to handle
>>> managed IRQ jobs.
>>>
>>> This API is introduced for the drivers that were previously relying only
>>> on num_online_cpus() to determine the number of MSIX vectors to create.
>>> In an RT environment with large isolated but fewer housekeeping CPUs this
>>> was leading to a situation where an attempt to move all of the vectors
>>> corresponding to isolated CPUs to housekeeping CPUs were failing due to
>>> per CPU vector limit.
>>>
>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>> ---
>>>  include/linux/sched/isolation.h | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>>> index cc9f393e2a70..2e96b626e02e 100644
>>> --- a/include/linux/sched/isolation.h
>>> +++ b/include/linux/sched/isolation.h
>>> @@ -57,4 +57,17 @@ static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
>>>  	return true;
>>>  }
>>>  
>>> +static inline unsigned int hk_num_online_cpus(void)
>> This breaks with the established naming of that header.
> I guess we can make it housekeeping_num_online_cpus() ?

Right, I can do that.

Thanks

>
-- 
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200924/12dbc9ec/attachment-0001.asc>
