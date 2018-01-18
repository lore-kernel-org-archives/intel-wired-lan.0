From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 18 Jan 2018 08:44:01 -0500
Subject: [Intel-wired-lan] [RFC v2 net-next 06/10] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <30e104db-3c88-b2f7-4494-98b2bece8ca9@mojatatu.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-7-jesus.sanchez-palencia@intel.com>
 <30e104db-3c88-b2f7-4494-98b2bece8ca9@mojatatu.com>
Message-ID: <8ca1bbaa-80fb-ef09-649d-0c143a48d9dc@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

One more comment:
Probably try to run a test with a very small delta with
no offload (probably using something like prio as the root qdisc)
and dump the stats.
My gut feeling is your accounting of the backlog in particular is off.

cheers,
jamal

On 18-01-18 08:35 AM, Jamal Hadi Salim wrote:
> On 18-01-17 06:06 PM, Jesus Sanchez-Palencia wrote:
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>
>> TBS (Time Based Scheduler) uses the information added earlier in this
>> series (the socket option SO_TXTIME and the new role of
>> sk_buff->tstamp) to schedule traffic transmission based on absolute
>> time.
>>
>> For some workloads, just bandwidth enforcement is not enough, and
>> precise control of the transmission of packets is necessary.
>>
>> Example:
>>
>> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
> 
> handle 100:0 ?
> 
>> ??????????? map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
>>
>> $ tc qdisc add dev enp2s0 parent 100:1 tbs delta 60000 clockid 11 
>> offload 1
>>
>>
>> In this example, the Qdisc will try to enable offloading (offload 1)
>> the control of the transmission time to the network adapter, the
>> time stamp in socket are in reference to the clockid '11' (CLOCK_TAI)
>> and packets leave the Qdisc "delta" (60000) nanoseconds before its
>> transmission time.
>>
> 
> 
>> When offloading is disabled, the network adapter will ignore the
>> sk_buff time stamp, and so, the transmission time will be only "best
>> effort" from the Qdisc.
>>
> 
> General comments:
> 1) iproute2: Avoid magic numbers like 1 or 11 please; "offload"
> (without 1) and "TAI" will be more human friendly.
> 
> 2) Experience shows that adding padding fields in the control structs
> implies they will _never ever_ be used. That was not design intent
> for netlink but over years shit like that has happened.
> Maybe look at using a 32 bitmap? It is more "future proof".
> You seem to only have 2-3 flags but it gives you opportunity
> to add more changes later. If you are 100% sure youll never need
> it - then maybe just move the tc_tbs_qopt::offload to the end of
> of the struct.
> 
> 3)It would be helpful for debugging to increment some stats other
> than drop counters on enqueu/dequeue obsolete packet drop. Maybe use
> overlimits for the dequeu drops (in addition)?
> 
> 4) I may be misreading things - but did you need to reset the
> watchdog on dequeue? It is already being kicked for every incoming packet.
> 
> cheers,
> jamal

