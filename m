From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 28 Sep 2017 16:07:25 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 2/3] net/sched: Introduce
	Credit Based Shaper (CBS) qdisc
In-Reply-To: <CAM_iQpUUUrYeyqYK-CDAXzuKcy9FDtq_etQQvO4D4uCjV6As-w@mail.gmail.com>
References: <20170926233916.11774-1-vinicius.gomes@intel.com>
 <20170926233916.11774-3-vinicius.gomes@intel.com>
 <CAM_iQpVrz+e=TYHYqaYyUWRP528GSZXx8EnN1yPhZK8eLvP4Yw@mail.gmail.com>
 <87lgkzg7xv.fsf@intel.com>
 <CAM_iQpUUUrYeyqYK-CDAXzuKcy9FDtq_etQQvO4D4uCjV6As-w@mail.gmail.com>
Message-ID: <87ing2fmmq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Cong Wang <xiyou.wangcong@gmail.com> writes:

[...]

>>>
>>> I am not sure how we can solve this elegantly, perhaps you should
>>> extend mqprio rather than add a new one?
>>
>> Is the alternative hinted in the FIXME worse? Instead of passing the
>> index of the hardware queue to the driver we pass the pointer to a
>> netdev_queue to the driver and it "discovers" the HW queue from that.
>
> Does this way solve the dependency on mqprio? If yes then it is good.
> And you have to fix it before merge, we don't have any qdisc depending
> a specific type of qdisc to be its parent.

Yes, it does. And if we do like Jesus pointed out, we can do this on the
CBS qdisc side, no need to change the driver.


Cheers,
--
Vinicius
