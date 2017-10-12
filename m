From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 12 Oct 2017 09:09:47 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v6 2/5] mqprio: Implement
 select_queue class_ops
In-Reply-To: <633dfce2-71f1-f704-7ae2-b1ef2ba9b448@intel.com>
References: <20171012005449.26533-1-vinicius.gomes@intel.com>
 <20171012005449.26533-3-vinicius.gomes@intel.com>
 <CAKgT0Ufo1tG4GpSkGaWuUxqhzEUOT7wcBLuaZx_mZmEL+9SnXw@mail.gmail.com>
 <633dfce2-71f1-f704-7ae2-b1ef2ba9b448@intel.com>
Message-ID: <CAKgT0UcpSq2-LaqDKhTWKoZdemDE2SOCWggxGBjCH98qYPBGFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 12, 2017 at 8:59 AM, Jesus Sanchez-Palencia
<jesus.sanchez-palencia@intel.com> wrote:
> Hi Alex,
>
>
> On 10/12/2017 08:21 AM, Alexander Duyck wrote:
>> On Wed, Oct 11, 2017 at 5:54 PM, Vinicius Costa Gomes
>> <vinicius.gomes@intel.com> wrote:
>>> From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>>>
>>> When replacing a child qdisc from mqprio, tc_modify_qdisc() must fetch
>>> the netdev_queue pointer that the current child qdisc is associated
>>> with before creating the new qdisc.
>>>
>>> Currently, when using mqprio as root qdisc, the kernel will end up
>>> getting the queue #0 pointer from the mqprio (root qdisc), which leaves
>>> any new child qdisc with a possibly wrong netdev_queue pointer.
>>>
>>> Implementing the Qdisc_class_ops select_queue() on mqprio fixes this
>>> issue and avoid an inconsistent state when child qdiscs are replaced.
>>>
>>> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>>> ---
>>>  net/sched/sch_mqprio.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
>>> index 6bcdfe6e7b63..8c042ae323e3 100644
>>> --- a/net/sched/sch_mqprio.c
>>> +++ b/net/sched/sch_mqprio.c
>>> @@ -396,6 +396,12 @@ static void mqprio_walk(struct Qdisc *sch, struct qdisc_walker *arg)
>>>         }
>>>  }
>>>
>>> +static struct netdev_queue *mqprio_select_queue(struct Qdisc *sch,
>>> +                                               struct tcmsg *tcm)
>>> +{
>>> +       return mqprio_queue_get(sch, TC_H_MIN(tcm->tcm_parent));
>>> +}
>>> +
>>
>> So I was just comparing this against mq_selet_queue, and I was
>> wondering why we are willing to return NULL here instead of just
>> returning a pointer to the first Tx queue? I realize there is the fix
>> in the first patch but it seems like if we are going to go that route
>> then maybe we should update mq as well so that both of these qdiscs
>> behave the same way. Either this should work like mq, or mq should
>> work like this, but we shouldn't have them exposing different
>> behaviors.
>
>
> This was brought up by Cong Wang during the review of our v2. Based on my
> understanding, the point I've made is that for mqprio the inner qdiscs are
> always 'related' to one of the Tx netdev_queues per design. Returning any other
> queue as a fallback seemed like going against that to me.
>
> I'm still inclined to say that we should keep this function as the patch is
> proposing, thus either returning the correct netdev_queue for a given handle, or
> NULL as a way to flag that something was 'wrong' with it. Returning queue #0 is
> misleading in that sense, imho.
>
> As for aligning mq_select_queue() with this approach, if my reasoning behind
> mqprio is correct and also applies to mq, I would be happy to send that fix as
> part our v7.
>
> What do you think?
>
>
> Thanks,
> Jesus

I think it would be better to bring mq_select_queue in line with your
fix. You could probably just add it to your first patch. That way if
the user specifies a bad qdisc classid they don't get to just
overwrite the qdisc on Tx queue 0.

- Alex
