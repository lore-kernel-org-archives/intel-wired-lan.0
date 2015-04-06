From: Vick, Matthew <matthew.vick@intel.com>
Date: Mon, 6 Apr 2015 18:33:40 +0000
Subject: [Intel-wired-lan] [net-next 20/25] fm10k: Add support for ITR
 scaling based on PCIe link speed
In-Reply-To: <5522BCC1.6040907@gmail.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-20-git-send-email-jeffrey.t.kirsher@intel.com>
 <55202A91.4080403@gmail.com> <D147FAF6.72258%matthew.vick@intel.com>
 <5522BCC1.6040907@gmail.com>
Message-ID: <D1481B56.7236D%matthew.vick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/6/15, 10:05 AM, "Alexander Duyck" <alexander.duyck@gmail.com> wrote:

>On 04/06/2015 09:39 AM, Vick, Matthew wrote:
>> On 4/4/15, 11:16 AM, "Alexander Duyck" <alexander.duyck@gmail.com>
>>wrote:
>>
>>> On 04/03/2015 01:27 PM, Jeff Kirsher wrote:

[...]

>>>> @@ -164,6 +165,9 @@ struct fm10k_ring_container {
>>>>  #define FM10K_ITR_10K		100	/* 100us */
>>>>  #define FM10K_ITR_20K		50	/* 50us */
>>>>  #define FM10K_ITR_ADAPTIVE	0x8000	/* adaptive interrupt moderation
>>>> flag */
>>>> +#define FM10K_ITR_SCALE_SMALL	60	/* Constant factor for small frames
>>>>*/
>>>> +#define FM10K_ITR_SCALE_MEDIUM	50	/* Constant factor for medium
>>>>frames
>>>> */
>>>> +#define FM10K_ITR_SCALE_LARGE	40	/* Constant factor for large frames
>>>>*/
>>>>  
>>>>  #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)
>>>>  
>>> These values don't make any sense to me, where did they come from?
>> They were experimental. I'll be the first to admit they probably aren't
>> perfect, but they're at least a significant improvement.
>>
>> Do you have some recommendations for interrupt rates at 25G/50G?
>>Depending
>> on what the targets are, it'd be nice to get these scalars to something
>>we
>> can shift by instead of divide by.
>
>If nothing else these need to be documented along with the expected
>range of interrupts per second.
>
>So for example if you expect the FM10K_ITR_SCALE_SMALL of 60 to be used
>with packets 300 bytes and smaller you should document somewhere that
>this is going to drive rates of 1 million to 200 thousand interrupts per
>second if that is what you actually want.  I was assuming that was a bug
>since that value seems obscenely high, however at 50Gb/s I supposed it
>is possible that you could theoretically push 70Mpps so in theory that
>might be appropriate if we were actually processing small packets at
>line rate..  :-)

That, um, was totally intentional. Yeah, 1 million interrupts or bust--I
totally didn't mess up the math when I had intended it to go up to 100k
int/s. :) Will definitely fix (and document) in v2.

>>>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>>>> b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>>>> index 1e08832..cd2e86a 100644
>>>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>>>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>>>> @@ -1395,11 +1395,20 @@ static void fm10k_update_itr(struct
>>>> fm10k_ring_container *ring_container)
>>>>  	if (avg_wire_size > 3000)
>>>>  		avg_wire_size = 3000;
>>>>  
>>>> -	/* Give a little boost to mid-size frames */
>>>> -	if ((avg_wire_size > 300) && (avg_wire_size < 1200))
>>>> -		avg_wire_size /= 3;
>>>> +	/* Simple throttle rate management based on average wire size,
>>>> +	 * providing boosts to small and medium packet loads. Divide the
>>>> +	 * average wire size by a constant factor to calculate the minimum
>>>> time
>>>> +	 * until the next interrupt in microseconds.
>>>> +	 */
>>>> +	if (avg_wire_size < 300)
>>>> +		avg_wire_size /= FM10K_ITR_SCALE_SMALL;
>>>> +	else if ((avg_wire_size >= 300) && (avg_wire_size < 1200))
>>>> +		avg_wire_size /= FM10K_ITR_SCALE_MEDIUM;
>>>>  	else
>>>> -		avg_wire_size /= 2;
>>>> +		avg_wire_size /= FM10K_ITR_SCALE_LARGE;
>>>> +
>>>> +	/* Scale for various PCIe link speeds */
>>>> +	avg_wire_size /= ring_container->ring->itr_scale;
>>>>  
>>>>  	/* write back value and retain adaptive flag */
>>>>  	ring_container->itr = avg_wire_size | FM10K_ITR_ADAPTIVE;
>>> This seems like all it is doing is maxing out the interrupt rate for
>>>all
>>> cases.  For example, a value of 1514 is reduced to 37.8.  When you use
>>> that as a usecs value that means the queue is capable of over 26K
>>> interrupts per second.
>>>
>>> The division by itr_scale is a really bad idea.  I would recommend
>>> replacing it with a shift and you should probably check for the value
>>> hitting 0.
>>>
>>> I suspect you probably aren't seeing much of a penalty because the
>>>MSI-X
>>> interrupt call is pretty cheap, however that is still a pretty high
>>> interrupt rate compared to past parts.
>> The interrupt rates are definitely open to suggestion. I tried to
>>maintain
>> the idea of the original algorithm, which did basically the same thing
>> (avg_wire_size divided by some scalar), so I'm not seeing what's
>> significantly different here from that angle.
>>
>> A shift for the itr_scale is a fair suggestion. I'll incorporate that
>>into
>> a v2.
>>
>> I definitely understand that I went with some high interrupt values, but
>> given the architecture of the device I'd be skeptical about dropping all
>> the way to 8000int/s.
>
>I think the big issue with this is that there is no bottom end.  So if
>you have a setup where you are running small packets your adjustment
>brings it all the way down to 1us since 60/60 is 1.  Then you also have
>to do a shift by 2 or divide by 4 for the PCIe gen1 which will bring the
>value down to 0 which isn't correct.
>
>What you probably need to do is look at creating a limit on just how low
>a value you can have.  Since you are having to do a divide by 4 after
>the computation you might make 4us the lowest value you can generate for
>this algorithm, and probably make that the limit, excluding ITR
>disabled, for user controllable interrupt moderation as well.  Then that
>way things are always at least throttled to no more than 250K
>interrupts/second per queue.  Otherwise there is s good chance that
>everything with packet size smaller than 240B will just end up with no
>interrupt moderation since that is currently being shifted off into
>oblivion.

And that's very much a bug I'll make sure to get fixed.

The accidentally unmoderated user input case is a good catch as well! I'll
add some lower bounds based on the PCIe link speed to the set_coalesce
call.

