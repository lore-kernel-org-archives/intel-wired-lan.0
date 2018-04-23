From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Mon, 23 Apr 2018 11:21:34 -0700
Subject: [Intel-wired-lan] [RFC v3 net-next 13/18] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <alpine.DEB.2.21.1803211407520.3754@nanos.tec.linutronix.de>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-14-jesus.sanchez-palencia@intel.com>
 <alpine.DEB.2.21.1803211407520.3754@nanos.tec.linutronix.de>
Message-ID: <768e8da5-502e-d36f-0f32-9324eaca4a1d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Thomas,


On 03/21/2018 06:46 AM, Thomas Gleixner wrote:
> On Tue, 6 Mar 2018, Jesus Sanchez-Palencia wrote:
>> +struct tbs_sched_data {
>> +	bool sorting;
>> +	int clockid;
>> +	int queue;
>> +	s32 delta; /* in ns */
>> +	ktime_t last; /* The txtime of the last skb sent to the netdevice. */
>> +	struct rb_root head;
> 
> Hmm. You are reimplementing timerqueue open coded. Have you checked whether
> you could reuse the timerqueue implementation?
> 
> That requires to add a timerqueue node to struct skbuff
> 
> @@ -671,7 +671,8 @@ struct sk_buff {
>  				unsigned long		dev_scratch;
>  			};
>  		};
> -		struct rb_node	rbnode; /* used in netem & tcp stack */
> +		struct rb_node		rbnode; /* used in netem & tcp stack */
> +		struct timerqueue_node	tqnode;
>  	};
>  	struct sock		*sk;
> 
> Then you can use timerqueue_head in your scheduler data and all the open
> coded rbtree handling goes away.


I just noticed that doing the above increases the size of struct sk_buff by 8
bytes - struct timerqueue_node is 32bytes long while struct rb_node is only
24bytes long.

Given the feedback we got here before against touching struct sk_buff at all for
non-generic use cases, I will keep the implementation of sch_tbs.c as is, thus
keeping the open-coded version for now, ok?

Thanks,
Jesus


(...)


