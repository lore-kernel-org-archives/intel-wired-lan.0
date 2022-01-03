From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Mon, 3 Jan 2022 12:40:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Minimize amount of
 busy-waiting during AQ send
In-Reply-To: <f4173e86-97c3-602f-4365-24fa13443822@molgen.mpg.de>
References: <20211116131329.626045-1-jedrzej.jagielski@intel.com>
 <ecdb8ef3-ccce-d17c-86d6-56f7e1e85606@molgen.mpg.de>
 <DM6PR11MB27317207BB69160027B04FEFF07D9@DM6PR11MB2731.namprd11.prod.outlook.com>
 <f4173e86-97c3-602f-4365-24fa13443822@molgen.mpg.de>
Message-ID: <DM6PR11MB27317E7AC5FF8EB3243F8ED2F0499@DM6PR11MB2731.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,

Thanks for suggestions, I appreciate it.
>
>
>>>> The i40e_asq_send_command will now use a non blocking
>>>> usleep_range if possible (non-atomic context), instead of busy-waiting
>>>> udelay. The usleep_range function uses hrtimers to provide better
>>>> performance and remove the negative impact of busy-waiting in
>>>
>>> remove*s*
>>>
>>>> time-critical environments.
>>>
>>> Please re-flow the paragraph for 75 characters per line.
>> 
>> Sure, it will be fixed.
>
>Thanks.
>
>>>> 1. Rename i40e_asq_send_command to i40e_asq_send_command_atomic
>>>>      and add 5th parameter to inform if called from an atomic context.
>>>>      Call inside usleep_range (if non-atomic) or udelay (if atomic).
>>>
>>> I prefer if `i40e_asq_send_command_atomic()` implicitly assumes it?s an
>>> atomic context without a fifth a parameter. To make it more clear, maybe
>>> even introduce `i40e_asq_send_command_nonatomic()`.
>> 
>> This function has been added in order to add possibility
>> to send commands in atomic context and reuse already existing
>> function 'i40e_asq_send_command' with previous signature
>> to avoid modifying all existing calls
>> to it. Parameter 'is_atomic" also
>> clearly provides information if function is being
>> invoked in atomic context or not.
>
>I disagree. Having a sixth function argument makes it more complicated, 
>and a function name containing `_atomic` does not need a parameter to 
>tell that it?s really atomic.
>
>If callers have to be updated, please update them.

I believe that in the drivers code function i40e_asq_send_command()
is invoked ~100 times. Your opinion is to update every single calling?
By inlining i40e_asq_send_command() in i40e_asq_send_command_atomic()
it isn't necessary.
Adding additional function _atomic with extra parameter makes
it possible to invoke this function in atomic or nonatomic context 
in a clear way  just by passing true/false.
In most of the cases i40e_asq_send_command() function is invoked in
nonatomic context.
>
>>>> 2. Change i40e_asq_send_command to invoke
>>>>      i40e_asq_send_command_atomic(..., false).
>>>>
>>>> 3. Change two functions:
>>>>       - i40e_aq_set_vsi_uc_promisc_on_vlan
>>>>       - i40e_aq_set_vsi_mc_promisc_on_vlan
>>>>      to explicitly use i40e_asq_send_command_atomic(..., true)
>>>>      instead of i40e_asq_send_command, as they use spinlocks and do some
>>>>      work in an atomic context.
>>>>      All other calls to i40e_asq_send_command remain unchanged.
>>>
>>> How can it be tested, that the busy-waiting is reduced? What perf(?)
>>> commands need to be executed?
>> 
>> This patch finds its use during an high-performance operations.
>> The goal of this patch is to reduce delay connected to
>> ASQ sending commands. Honestly I don't know in which test case
>> it can be checked.
>
>Further below, you write it has been checked. Please add the benchmark 
>figures to the commit message.

This patch has been requested by one of the clients - they
have noticed that calling i40e_asq_send_command() function
has been adding too big delay while working with hi-perf tasks. 
After that fix they tested it so we have no access to results.
>
>>>> Title: Minimize amount of busy-waiting during AQ send
>>>
>>> Tag not needed.
>> 
>> Sure, it will be removed.
>>>
>>>> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
>>>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/i40e/i40e_adminq.c | 29 ++++++++++++++-----
>>>>    drivers/net/ethernet/intel/i40e/i40e_common.c |  6 ++--
>>>>    .../net/ethernet/intel/i40e/i40e_prototype.h  | 14 +++++----
>>>>    3 files changed, 35 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> index 593912b17609..7abef88801fb 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> @@ -769,21 +769,22 @@ static bool i40e_asq_done(struct i40e_hw *hw)
>>>>    }
>>>>    
>>>>    /**
>>>> - *  i40e_asq_send_command - send command to Admin Queue
>>>> + *  i40e_asq_send_command_atomic - send command to Admin Queue
>>>>     *  @hw: pointer to the hw struct
>>>>     *  @desc: prefilled descriptor describing the command (non DMA mem)
>>>>     *  @buff: buffer to use for indirect commands
>>>>     *  @buff_size: size of buffer for indirect commands
>>>>     *  @cmd_details: pointer to command details structure
>>>> + *  @is_atomic_context: is the function called in an atomic context?
>>>>     *
>>>>     *  This is the main send command driver routine for the Admin Queue send
>>>>     *  queue.  It runs the queue, cleans the queue, etc
>>>>     **/
>>>> -i40e_status i40e_asq_send_command(struct i40e_hw *hw,
>>>> -				struct i40e_aq_desc *desc,
>>>> -				void *buff, /* can be NULL */
>>>> -				u16  buff_size,
>>>> -				struct i40e_asq_cmd_details *cmd_details)
>>>> +i40e_status
>>>> +i40e_asq_send_command_atomic(struct i40e_hw *hw, struct i40e_aq_desc *desc,
>>>> +			     void *buff, /* can be NULL */ u16  buff_size,
>>>> +			     struct i40e_asq_cmd_details *cmd_details,
>>>> +			     bool is_atomic_context)
>>>>    {
>>>>    	i40e_status status = 0;
>>>>    	struct i40e_dma_mem *dma_buff = NULL;
>>>> @@ -910,7 +911,12 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
>>>>    			 */
>>>>    			if (i40e_asq_done(hw))
>>>>    				break;
>>>> -			udelay(50);
>>>> +
>>>> +			if (is_atomic_context)
>>>> +				udelay(50);
>>>> +			else
>>>> +				usleep_range(40, 60);
>>>> +
>>>
>>> Please mention in the commit message, why the range is 40 to 60 and not
>>> 10 to 50 for example? I would have expected the upper bound to remain 50.
>> 
>> This range was chosen so that the value in the middle is to be 50ms.
>> The audibility of this assumption was confirmed during tests; the change had
>> a positive effect on high-perf operations. Anyway it will be mentioned in the
>> commit msg.
>
>Did you test with an upper bound of 50, so `usleep_range(40, 60);`? What 
>lower bound does the datasheet require?

It hasn't been tested with an upper bound of 50 - only with 60, but client
assured that it works as expected. Patch has provided an improvement.
>
>
>Kind regards,
>
>Paul

Best regards,
Jedrzej
