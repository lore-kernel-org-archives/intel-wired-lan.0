From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 11 Apr 2022 16:36:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next v4 11/12] igc: Check
 incompatible configs for Frame Preemption
In-Reply-To: <20210628092003.bribdjfaxwnpdt5f@skbuf>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
 <20210626003314.3159402-12-vinicius.gomes@intel.com>
 <20210628092003.bribdjfaxwnpdt5f@skbuf>
Message-ID: <87wnfvchv9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Fri, Jun 25, 2021 at 05:33:13PM -0700, Vinicius Costa Gomes wrote:
>> Frame Preemption and LaunchTime cannot be enabled on the same queue.
>> If that situation happens, emit an error to the user, and log the
>> error.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>
> This is a very interesting limitation, considering the fact that much of
> the frame preemption validation that I did was in conjunction with
> tc-etf and SO_TXTIME (send packets on 2 queues, one preemptible and one
> express, and compare the TX timestamps of the express packets with their
> scheduled TX times). The base-time offset between the ET and the PT
> packets is varied in small increments in the order of 20 ns or so.
> If this is not possible with hardware driven by igc, how do you know it
> works properly? :)

Good question. My tests were much less accurate than what you were
doing, I was basically flooding the link with preemptable packets, and
sending some number of express packets, and counting them using some
debug counters on the receiving side.


Cheers,
-- 
Vinicius
