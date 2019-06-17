From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jun 2019 16:23:08 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v3 5/6] taprio: make clock
 reference conversions easier
In-Reply-To: <1560799870-18956-6-git-send-email-vedang.patel@intel.com>
References: <1560799870-18956-1-git-send-email-vedang.patel@intel.com>
 <1560799870-18956-6-git-send-email-vedang.patel@intel.com>
Message-ID: <20190617.162308.2157008404980622764.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vedang Patel <vedang.patel@intel.com>
Date: Mon, 17 Jun 2019 12:31:09 -0700

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index ab6080013666..f63cc3a9e69a 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
 ...
>  	return ns_to_ktime(sched->base_time);
>  }
>  
> +static inline ktime_t taprio_get_time(struct taprio_sched *q)
> +{

Please don't use inline here.
