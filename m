From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Oct 2015 19:17:03 -0700
Subject: [Intel-wired-lan] [next-queue 13/17] fm10k: Update adaptive ITR
 algorithm
In-Reply-To: <1444866649.26286.58.camel@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-13-git-send-email-jacob.e.keller@intel.com>
 <561EA08C.8090705@gmail.com> <1444853538.26286.42.camel@intel.com>
 <561ED9F1.5060104@gmail.com> <1444866649.26286.58.camel@intel.com>
Message-ID: <561F0C9F.6040900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/14/2015 04:50 PM, Keller, Jacob E wrote:
> On Wed, 2015-10-14 at 15:40 -0700, Alexander Duyck wrote:
>> On 10/14/2015 01:12 PM, Keller, Jacob E wrote:
>>> On Wed, 2015-10-14 at 11:35 -0700, Alexander Duyck wrote:
>>>> On 10/13/2015 04:39 PM, Jacob Keller wrote:
>>>> +	 */+#define FM10K_ITR_SCALE_SMALL	6
>>>>> +#define FM10K_ITR_SCALE_MEDIUM	5
>>>>> +#define FM10K_ITR_SCALE_LARGE	4
>>>>> +
>>>>> +	if (avg_wire_size < 300)
>>>>> +		avg_wire_size *= FM10K_ITR_SCALE_SMALL;
>>>>> +	else if ((avg_wire_size >= 300) && (avg_wire_size <
>>>>> 1200))
>>>>> +		avg_wire_size *= FM10K_ITR_SCALE_MEDIUM;
>>>>>     	else
>>>>> -		avg_wire_size /= 2;
>>>>> +		avg_wire_size *= FM10K_ITR_SCALE_LARGE;
>>>>> +
>>>> Where is it these scaling values originated from?  Just looking
>>>> through
>>>> the values I am not sure having this broken out like it is
>>>> provides
>>>> much
>>>> value.
>>>>
>>> I am not really sure what exactly you mean here?
>>
>> The numbers are kind of all over the place.  The result of the math
>> above swings back and forth in a saw tooth between values and doesn't
>> seem to do anything really consistent.
>>
>> For example a packet that is 275 in size will have an interrupt rate
>> of
>> 125K interrupts per second, while a packet that is 276 bytes in size
>> with be closer to 166K.  It is basically creating some odd peaks and
>> valleys.
>>
>
> Yea ok this does do a lot of weird things. I can definitely look at
> implementing what you suggest below and see how it goes..
>
>>>
>>>> What I am getting at is that the input is a packet size, and the
>>>> output
>>>> is a value somewhere between 2 and 47.  (I think that 47 is still
>>>> a
>>>> bit
>>>> high by the way and probably should be something more like 25
>>>> which I
>>>> believe you established as the minimum Tx interrupt rate in a
>>>> later
>>>> patch.)
>>>>
>>> The input is two fold for calculation, packet size, and number of
>>> packets.
>>
>> Last I knew though the average packet size is the only portion we end
>> up
>> using to actually set the interrupt moderation rate.
>>
>
> You're correct right now we calculate average wiresize and only use
> that, no mention of total packet as well.
>
>>>> What you may want to do is look at pulling in the upper limit to
>>>> something more reasonable like 1536 for avg_wire_size, and then
>>>> simplify
>>>> this logic a bit.  Specifically what is it you are trying to
>>>> accomplish
>>>> by tweaking the scale factor like you are?  I assume you are
>>>> wanting
>>>> to
>>>> approximate a curve.  If so you might wan to look at possibly
>>>> including
>>>> an offset value so that you can smooth out the points where your
>>>> intersections occur.
>>>>
>>> I honestly don't know. I mostly took the original work from 6-7
>>> months
>>> ago, and added your suggestions from that series, but maybe that
>>> isn't
>>> valid now?
>>
>> I suspect some of my views have changed over the last several months
>> after dealing with interrupt moderation issues on ixgbe.
>>
>
> Sure. It's a complicated problem.
>
>> The thing I started realizing is that with full sized Ethernet
>> frames,
>> 1514 bytes in size, you have a maximum rate of something like 4
>> million
>> packets per second at 50Gbps.  It seems like you should be firing an
>> interrupt once every 100 packets at least don't you think?  That is
>> why
>> I am now thinking at minimum 40K interrupts per second is necessary.
>> However a side effect of that is that 100 packets will overrun a UDP
>> buffer in most cases as there is only room for about 70 frames based
>> on
>> math I saw when I submitted the patch for ixgbe
>> (https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/comm
>> it/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c?id=8ac34f10a5ea4c7b6
>> f57dfd52b0693a2b67d9ac4).
>> So if I want to take UDP rmem_default into account we would be
>> looking
>> at something more like 60K interrupts per second which is getting
>> fairly
>> tiny at 17us
>>
>
> Ok.
>
>>>> For example what you may want to consider doing would be to
>>>> instead
>>>> use
>>>> a multiplication factor for small, an addition value for medium,
>>>> and
>>>> for
>>>> large you simply cap it at a certain value.
>>>>
>>> So, how would this look? The capping makes sense, we should
>>> probably
>>> cap it at around 30 or something? I'm not sure that 25 is the
>>> limit,
>>> since for some workloads I think we did calculate that we could use
>>> that few interrupts.. maybe the CPU savings aren't worth it though
>>> if
>>> it messes up too many other flows?
>>
>> So I have done some math based on an assumption of a 212992
>> wmem_default
>> and a overhead of 640 bytes per packet (256 skb, 64 headroom, 320
>> shared
>> info).  Breaking it all down goes a little something like this:
>>
>>       wmem_default / (size + overhead) = desired_pkts_per_int
>>       rate / bits_per_byte / (size + ethernet_overhead) = pkt_rate
>>       (desired_pkts_per_int / pkt_rate) * usec_per_sec = ITR value
>>
>> So then when we start plugging in the numbers:
>>       212992 / (size + 640) = desired_pkts_per_int
>>
>> we can simplify the second expression by just doing the division now.
>>       50,000,000,000 / 8 / (size + 24) = pkt_rate
>>       6,250,000,000/(size + 24) = pkt_rate
>>
>> Then we just need to plug in the values and reduce:
>>       (212,992 / (size + 640)) / (6,250,000,000/(size + 24)) *
>> 1,000,000
>> = ITR value
>>       (212,992/(size + 640)) / (6,250/(size + 24)) = ITR value
>>       (34.078/(size + 640))/(1/(size+24) = ITR value
>>       (34 * (size + 24))/(size + 640) = ITR value
>>
>> So now we have the expression we are looking for in order to
>> determine
>> the minimum interrupt rate, but we want to avoid the division.  So in
>> the end we have something that looks like this in order to generate
>> an
>> approximation of the curve without having to do any unnecessary math
>> (dropping the +24, and the 3000 limit from earlier):
>>
>>       /* the following is a crude approximation for the following
>> expression:
>>        * (34 * (size + 24))/(size + 640) = ITR value
>>        * /
>>       if (avg_wire_size <= 360) {
>>           /* start 333K ints/sec and gradually drop to 77K ints/sec */
>>           avg_wire_size *= 8;
>>           avg_wire_size += 376;
>>       } else if (avg_wire_size <= 1152) {
>>           /* 77K ints/sec to 45K ints/sec
>>           avg_wire_size *= 3;
>>           avg_wire_size += 2176;
>>       } else if (avg_wire_size <= 1920) {
>>           /* 45K ints/sec to 38K ints/sec
>>           avg_wire_size += 4480;
>>       } else {
>>           /* plateau at a limit of 38K ints/sec */
>>           avg_wire_size = 6656;
>>       }
>>
>
> So this is calculating the inverse ints/sec? where do we end up
> converting this to microseconds. Hmm.

The value generated at the end is in microseconds.  Basically this would 
replace all the code that is located before your shift at the end that 
uses the PCIe factor + 8.  So everything from the size > 3000 check down 
to the adjustments for the other sizes.

I kind of always hated the algorithms that try to work everything out in 
terms of interrupts and then have to flip it over and into microseconds. 
  This is just working with the raw microseconds like the fm10k driver 
currently does.

>> Mind you the above is a crude approximation, but it should give
>> decent
>> performance and it only strays from the values of the original
>> function
>> by 1us or 2us and it stays under the curve.  It could probably use
>> some
>> tuning and tweaking as well but you get the general idea.
>>
>> You may even want to tune this to be a bit more aggressive in terms
>> of
>> interrupts per second.  I know some distros such as RHEL are still
>> running around with an untuned skb_shared_info and such and as a
>> result
>> they take up more space resulting in a larger memory footprint.  What
>> this would represent is modifying the 640 value in the original
>> function
>> to increase based on the extra overhead.  Then it would be necessary
>> to
>> modify the slopes, offsets, and transitions points to get the right
>> approximation for the new curve.
>>
>>> I could also try to take a completely different algorithm say from
>>> i40e
>>> instead? This one really has limited testing.
>>
>> Yeah, this one was a "good enough" solution at the time and as I
>> recall
>> it was a clone of the igb interrupt moderation.  Now that you have
>> real
>> ports you probably need something better than 1Gbps.
>>
>> The i40e one is from ixgbe, which was inherited from e1000.  The
>> problem
>> with the interrupt moderation in that design is that for any high
>> throughput usage everything becomes bulk (8K ints per second). For 1G
>> that works fine.  But I can tell you from what I have seen on 10Gbps
>> NICs it doesn't do well under any kind of small packet, or single
>> threaded throughput test.
>>
>>
>
> Agreed ok. I will look into this more.
>
> Regards,
> Jake

I'll probably be submitting some patches for ixgbe at some point to try 
and shape it into something similar.  Really the only issue right now is 
how to deal with the combined Rx/Tx ITR register since ixgbe only has 
one whereas the FM10K can maintain a separate one in each direction.

- Alex

