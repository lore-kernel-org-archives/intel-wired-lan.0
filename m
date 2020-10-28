From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 28 Oct 2020 16:14:59 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 0/9] Introduce biased
 busy-polling
In-Reply-To: <CANn89iLpwne8P+E4p+wD92xB0LP4WridLUhPQTx1CeDF-D+LdA@mail.gmail.com>
References: <20201028133437.212503-1-bjorn.topel@gmail.com>
 <CANn89iLpwne8P+E4p+wD92xB0LP4WridLUhPQTx1CeDF-D+LdA@mail.gmail.com>
Message-ID: <149e5989-86c5-d9f4-3307-a55bc696d639@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-10-28 15:13, Eric Dumazet wrote:
> On Wed, Oct 28, 2020 at 2:35 PM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
[...]
>> Performance UDP sockets:
>>
>> I hacked netperf to use non-blocking sockets, and looping over
>> recvfrom(). The following command-line was used:
>>    $ netperf -H 192.168.1.1 -l 30 -t UDP_RR -v 2 -- \
>>        -o min_latency,mean_latency,max_latency,stddev_latency,transaction_rate
>>
>> Non-blocking:
>>    16,18.45,195,0.94,54070.369
>> Non-blocking with biased busy-polling:
>>    15,16.59,38,0.70,60086.313
>>
> 
> But a fair comparison should be done using current busy-polling mode,
> which does not require netperf to use non-blocking mode in the first place ?
>

Yeah, good point! I'll make sure to add that.

One difference between biased/regular is that for elephant flows,
regular falls back to softirq processing, where as the biased stay in
"busy-polling mode". Further, if the softirq is really busy due to heavy
load (traffic) busy-polling will never be entered.


> Would disabling/rearming interrupts about 60,000 times per second
> bring any benefit ?
>

Not following, Eric. Wdym?

> 
> Additional questions :
> 
> - What happens to the gro_flush_timeout and accumulated TCP segments
> in GRO engine
> while the biased busy-polling is in use ?
>
> - What mechanism would avoid a potential 200 ms latency when the
> application wants to exit cleanly ?
>    Presumably when/if SO_BIAS_BUSY_POLL is used to clear
> sk->sk_bias_busy_poll we need
>   to make sure device interrupts are re-enabled.
>

Yes, good questions/input. I'll look into the first one. As for the
second one; I'd say this should be implemented! Thanks!


Cheers,
Bj?rn

