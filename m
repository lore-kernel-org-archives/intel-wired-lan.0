From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 20 Sep 2021 12:02:37 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: update dim usage
 and moderation
In-Reply-To: <d87087e8-51d7-4fd2-d594-a79b126fa14c@molgen.mpg.de>
References: <20210824011259.738307-1-jesse.brandeburg@intel.com>
 <20210824011259.738307-2-jesse.brandeburg@intel.com>
 <d87087e8-51d7-4fd2-d594-a79b126fa14c@molgen.mpg.de>
Message-ID: <7ebc8fa6-79d0-13a3-e07a-247bfe8d8bcd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/19/2021 11:46 PM, Paul Menzel wrote:
> Dear Jesse,

Thanks for reviewing, I applied your text changes to v4.

> Am 24.08.21 um 03:12 schrieb Jesse Brandeburg:
>> Add a new helper for setting rate limit, which will be used more
>> in a followup patch.
> 
> Nice work. Could you please add, how to run the ping-pong test, so
> others can verify the behavior?

The test ran 32 rounds of netperf -t TCP_RR with a single thread, with
sizes of bytes transferred varying in powers of two from 1-64K.
each command was something like (for example for the 8K ping pong)
netperf -t TCP_RR -H host -l 30 -- -r 8K


>> @@ -1328,15 +1345,14 @@ static u32 ice_buildreg_itr(u16 itr_idx, u16 itr)
>> ? }
>> ? ? /**
>> - * ice_update_ena_itr - Update ITR moderation and re-enable MSI-X
>> interrupt
>> + * ice_enable_interrupt - re-enable MSI-X interrupt
>> ?? * @q_vector: the vector associated with the interrupt to enable
>> ?? *
>> - * Update the net_dim() algorithm and re-enable the interrupt
>> associated with
>> - * this vector.
>> - *
>> - * If the VSI is down, the interrupt will not be re-enabled.
>> + * If the VSI is down, the interrupt will not be re-enabled. Also,
>> + * when enabling the interrupt always reset the wb_on_itr to false
>> + * and trigger a software interrupt to clean out internal state.
> 
> Is the internal state cleaning required in the spec?

It is mentioned in the interrupt management section that triggering a
software interrupt will "flush" internal state. The spec just doesn't
mention when you should use that trick.

