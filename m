From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jun 2019 16:22:45 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v3 4/6] taprio: Add support
 for txtime-assist mode.
In-Reply-To: <1560799870-18956-5-git-send-email-vedang.patel@intel.com>
References: <1560799870-18956-1-git-send-email-vedang.patel@intel.com>
 <1560799870-18956-5-git-send-email-vedang.patel@intel.com>
Message-ID: <20190617.162245.717911211395007022.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vedang Patel <vedang.patel@intel.com>
Date: Mon, 17 Jun 2019 12:31:08 -0700

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index a41d7d4434ee..ab6080013666 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
 ...
> +/* Get how much time has been already elapsed in the current cycle. */
> +static inline s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
> +{

Please do not use the inline directive in foo.c files, let the compiler decide.

 ...
> +static inline int length_to_duration(struct taprio_sched *q, int len)
> +{
> +	return (len * atomic64_read(&q->picos_per_byte)) / 1000;
> +}

Likewise.

 ...
> +static inline ktime_t get_cycle_start(struct sched_gate_list *sched,
> +				      ktime_t time)
> +{

Likewise.
