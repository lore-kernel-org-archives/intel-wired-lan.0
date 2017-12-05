From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 05 Dec 2017 13:22:07 -0800
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 0/6] Time based packet
 transmission
In-Reply-To: <20170918.093436.1069699729581966538.davem@davemloft.net>
References: <cover.1505719061.git.rcochran@linutronix.de>
 <20170918.093436.1069699729581966538.davem@davemloft.net>
Message-ID: <87609kj2f4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David,

David Miller <davem@davemloft.net> writes:

> From: Richard Cochran <rcochran@linutronix.de>
> Date: Mon, 18 Sep 2017 09:41:15 +0200
>
>>   - The driver does not handle out of order packets.  If user space
>>     sends a packet with an earlier Tx time, then the code should stop
>>     the queue, reshuffle the descriptors accordingly, and then
>>     restart the queue.
>
> The user should simply be not allowed to do this.
>
> Once the packet is in the device queue, that's it.  You cannot insert
> a new packet to be transmitted before an already hw queued packet,
> period.
>
> Any out of order request should be rejected with an error.

Just to clarify, I agree that after after the packet is enqueued to the
HW, there's no going back, in another words, we must never enqueue
anything to the HW with a timestamp earlier than the last enqueued
packet.

But re-ordering packets at the Qdisc level is, I think, necessary: two
applications (one (A) with period of 50us and the other (B) of 100us),
if it happens that (B) enqueues its packet before (A), I think, we would
have a problem.

The problem is deciding for how long we should keep packets in the Qdisc
queue. In the implementation we are working on, this is left for the
user to decide.

Or do you have a reason for not doing *any* kind of re-ordering?

>
> I'd say the same is true for requests to send packets timed
> in the past.

+1


Cheers,
--
Vinicius
