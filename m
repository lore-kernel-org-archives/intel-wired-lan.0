From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 03 Oct 2017 20:47:11 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v3 2/4] net/sched: Fix
 accessing invalid dev_queue
In-Reply-To: <20171003234435.8979-3-vinicius.gomes@intel.com>
References: <20171003234435.8979-1-vinicius.gomes@intel.com>
 <20171003234435.8979-3-vinicius.gomes@intel.com>
Message-ID: <1507088831.8061.41.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-10-03 at 16:44 -0700, Vinicius Costa Gomes wrote:
> From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> 
> In qdisc_alloc() the dev_queue pointer was used without any checks being
> performed. If qdisc_create() gets a null dev_queue pointer, it just
> passes it along to qdisc_alloc(), leading to a crash. That happens if a
> root qdisc implements select_queue() and returns a null dev_queue
> pointer for an "invalid handle", for example.
> 
> One way to reproduce that is:
> 
> 1) Setup mqprio
> $ tc qdisc replace dev enp3s0 parent root mqprio num_tc 3 \
>      	   map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
> 2) Replace the first inner qdisc
> $ tc qdisc replace dev enp3s0 parent 8001:1 pfifo_fast
> 
> This will lead to the following crash:

When was this bug added ?

If this is a consequence of your prior patch (1/4), then this must come
before it.

No need to add a stack trace for a not existing bug.
Instead, explain in the changelog that it is a prep work.

We try to not break the tree on purpose, so that future bisection will
not hit a point where the kernel crashes.


