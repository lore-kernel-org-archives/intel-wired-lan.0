From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 19 May 2020 08:32:40 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <b33e582f-e0e6-467a-636a-674322108855@ti.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <b33e582f-e0e6-467a-636a-674322108855@ti.com>
Message-ID: <87v9ksndnr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Murali Karicheri <m-karicheri2@ti.com> writes:

>> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0
>> Frame preemption settings for enp3s0:
>> 	support: supported
>> 	active: active
>> 	supported queues: 0xf
>
> I assume this is will be in sync with ethtool -L output which indicates
> how many tx h/w queues present? I mean if there are 8 h/w queues,
> supported queues will show 0xff.

In this approach, the driver builds these bitmasks, so it's responsible
to keep it consistent with the rest of the stuff that's exposed in
ethtool.

>
>> 	supported queues: 0xe
>  From the command below, it appears this is the preemptible queue mask.
> bit 0  is Q0, bit 1 Q1 and so forth. Right? In that case isn't it more
> clear to display
>          preemptible queues : 0xef
>
> In the above Q7 is express queue and Q6-Q0 are preemptible.

In my case, the controller I have here only has 4 queues, and Queue 0 is
the highest priority one, and it's marked as express.

>
> Also there is a handshake called verify that happens which initiated
> by the h/w to check the capability of peer. It looks like
> not all vendor's hardware supports it and good to have it displayed
> something like
>
>          Verify supported/{not supported}
>
> If Verify is supported, FPE is enabled only if it succeeds. So may be
> good to show a status of Verify if it is supported something like
>          Verify success/Failed
>
>> 	minimum fragment size: 68
>> 
>> 
>> $ ethtool --set-frame-preemption enp3s0 fp on min-frag-size 68 preemptible-queues-mask 0xe
>> 
>> This is a RFC because I wanted to have feedback on some points:
>> 
>>    - The parameters added are enough for the hardware I have, is it
>>      enough in general?
>
> As described above, it would be good to add an optional parameter for
> verify
>
> ethtool --set-frame-preemption enp3s0 fp on min-frag-size 68 
> preemptible-queues-mask 0xe verify on
>

The hardware I have do not support this, but this makes sense.


Cheers,
-- 
Vinicius
