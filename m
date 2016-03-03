From: David Miller <davem@davemloft.net>
Date: Thu, 03 Mar 2016 16:25:46 -0500 (EST)
Subject: [Intel-wired-lan] [net-next PATCH] net: relax setup_tc ndo op
	handle restriction
In-Reply-To: <20160229192613.24163.31830.stgit@john-Precision-Tower-5810>
References: <20160229192613.24163.31830.stgit@john-Precision-Tower-5810>
Message-ID: <20160303.162546.1789026863325812592.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 29 Feb 2016 11:26:13 -0800

> I added this check in setup_tc to multiple drivers,
> 
>  if (handle != TC_H_ROOT || tc->type != TC_SETUP_MQPRIO)
> 
> Unfortunately restricting to TC_H_ROOT like this breaks the old
> instantiation of mqprio to setup a hardware qdisc. This patch
> relaxes the test to only check the type to make it equivalent
> to the check before I broke it. With this the old instantiation
> continues to work.
> 
> A good smoke test is to setup mqprio with,
> 
> # tc qdisc add dev eth4 root mqprio num_tc 8 \
>   map 0 1 2 3 4 5 6 7 \
>   queues 0 at 0 1 at 1 2 at 2 3 at 3 4 at 4 5 at 5 6 at 6 7 at 7
> 
> Fixes: e4c6734eaab9 ("net: rework ndo tc op to consume additional qdisc handle paramete")
> Reported-by: Singh Krishneil <krishneil.k.singh@intel.com>
> Reported-by: Jake Keller <jacob.e.keller@intel.com>
 ...
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>

Applied, thanks John.
