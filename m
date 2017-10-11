From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 11 Oct 2017 22:38:32 +0200
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v4 0/6] tc-flower
 based cloud filters in i40e
In-Reply-To: <CAKgT0UcP8refj2KLMT258xPNS2h3KhLqKD5sJkNLXRdNJrRCVg@mail.gmail.com>
References: <150768099999.5320.1633617713417675266.stgit@anamdev.jf.intel.com>
 <20171011125635.GD2039@nanopsycho>
 <CAKgT0UcP8refj2KLMT258xPNS2h3KhLqKD5sJkNLXRdNJrRCVg@mail.gmail.com>
Message-ID: <20171011203832.GA9297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wed, Oct 11, 2017 at 07:46:27PM CEST, alexander.duyck at gmail.com wrote:
>On Wed, Oct 11, 2017 at 5:56 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>> Wed, Oct 11, 2017 at 02:24:12AM CEST, amritha.nambiar at intel.com wrote:
>>>This patch series enables configuring cloud filters in i40e
>>>using the tc-flower classifier. The classification function
>>>of the filter is to match a packet to a class. cls_flower is
>>>extended to offload classid to hardware. The offloaded classid
>>>is used direct matched packets to a traffic class on the device.
>>>The approach here is similar to the tc 'prio' qdisc which uses
>>>the classid for band selection. The ingress qdisc is called ffff:0,
>>>so traffic classes are ffff:1 to ffff:8 (i40e has max of 8 TCs).
>>
>>
>> NACK. This clearly looks like abuse of classid to something
>> else. Classid is here to identify qdisc instance. However, you use it
>> for hw tclass identification. This is mixing of apples and oranges.
>>
>> Why?
>>
>> Please don't try to abuse things! This is not nice.
>
>This isn't an abuse. This is reproducing in hardware what is already
>the behavior for software. Isn't that how offloads are supposed to
>work?

What is meaning of classid in HW? Classid is SW only identification of
qdisc instances. No relation to HW instances = abuse.


>
>This is exactly how prio currently handles this. We are essentially
>doing the exact same thing in the hardware where we are choosing a
>queueing group based on the class ID. You could setup a prio qdisc. If
>you are offloading a qdisc behavior into hardware how are you supposed
>to emulate the behavior if you aren't allowing the offload to use the
>same mechanism?

I believe that the correct way to solve is to introduce SETTCLASS
termination action (similar to TRAP, GOTO_CHAIN, etc), which would allow
user to instruct the destination tclass and driver can offload it.
