From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Thu, 7 Sep 2017 16:56:19 +0200
Subject: [Intel-wired-lan] Tuning the napi_poll function.
Message-ID: <CAGv3bDfGVD75dEQGwjUFQt0EpCsJwvO-L60WMXO+_vA4zF+ejw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have gone through multiple posts (in and outside Stackoverflow) regarding
this topic. Currently, I am working on to modify the i40e-2.0.30 driver for
Intel X710 NIC.

My query is particularly concerned with the NAPI Poll mechanism. I
understand that napi_poll function is triggered when a packet arrives, and
if the amount of work done while receiving the packets exceeds the
allocated budget, NAPI Polling continues; else polling stops.

Based on this information, I modified my driver to keep polling if a
particular signature of data arrives on a particular queue ( using flow
director), e.g. UDP Packets on Port XXX for 10,000 poll cycles. But, I am
trying to eliminate the possibility of interrupts as much as possible.

Thus, here is my main question. Will I be able to schedule the NAPI poll to
be executed at a certain point in time ? Like, I want NAPI poll to be
executed every 500 ms and may be last for 20ms. For instance, I will be
expecting my packet at time *T ms*, while I might start the polling at
time *(T-10)
ms* and stop polling at *(T + 10) ms*. This may, I might be able to reduce
the usage of interrupts. Right now, I have been resetting the interrupts
every 10,000 poll cycles.

Any explanation or reference on this would be really helpful.


Regards,
Kushal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/8698f32f/attachment.html>
