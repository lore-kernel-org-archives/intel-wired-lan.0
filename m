From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 29 Jan 2021 15:42:05 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <20210129232015.atl4336zqy4ev3bi@skbuf>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-3-vinicius.gomes@intel.com>
 <20210126000924.jjkjruzmh5lgrkry@skbuf>
 <87wnvvsayz.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210129232015.atl4336zqy4ev3bi@skbuf>
Message-ID: <87zh0rqpiq.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Fri, Jan 29, 2021 at 01:13:24PM -0800, Vinicius Costa Gomes wrote:
>> > Secondly, why should at least one queue be preemptible? What's wrong
>> > with frame preemption being triggered by a tc-taprio window smaller than
>> > the packet size? This can happen regardless of traffic class.
>>
>> It's the opposite, at least one queue needs to be marked
>> express/non-preemptible.
>
> I meant to ask why should at least one queue be express. The second part
> of the question remains valid.
>
>> But as I said above, perhaps this should be handled in a per-driver
>> way. I will remove this from taprio.
>>
>> I think removing this check/limitation from taprio should solve the
>> second part of your question, right?
>
> Nope. Can you point me to either 802.1Q or 802.3 saying that at least
> one priority should go to the express MAC?

After re-reading Anex Q, I know it's informative, and
thinking/remembering things a bit better, it seems that the standard
only defines preemption of express queues/priorities over preemptible
traffic. The standard doesn't talk about preemptible pririoties
preempting other preemptible priorities.

So, if there's no express queue, no preemption is going to happen, so it
shouldn't be enabled, to avoid like an invalid/useless state.

So I am going to take back my previous email: this seems like it's
better to be kept in a centralized place.


Cheers,
-- 
Vinicius
