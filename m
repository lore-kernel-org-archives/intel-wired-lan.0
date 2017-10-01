From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 30 Sep 2017 17:22:33 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/5] net/sched: Fix
	accessing invalid dev_queue
In-Reply-To: <20170930002657.15291-3-vinicius.gomes@intel.com>
References: <20170930002657.15291-1-vinicius.gomes@intel.com>
 <20170930002657.15291-3-vinicius.gomes@intel.com>
Message-ID: <CAM_iQpW7YtS2=rRw814=zWcJaUOGmkWQ+NHQKPwsBF4hMQSRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 29, 2017 at 5:26 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>
> In qdisc_alloc() the dev_queue pointer was used without any checks being
> performed. If qdisc_create() gets a null dev_queue pointer, it just
> passes it along to qdisc_alloc(), leading to a crash. That happens if a
> root qdisc implements select_queue() and returns a null dev_queue
> pointer for an "invalid handle", for example.

Does it make sense to let mqprio_select_queue() always return
non-NULL?

At least mq_select_queue() returns queue #0 as a fallback.
