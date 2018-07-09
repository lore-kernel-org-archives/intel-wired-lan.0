From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 9 Jul 2018 09:07:23 -0700
Subject: [Intel-wired-lan] [PATCH v3 07/11] igc: Add HW initialization
 code
In-Reply-To: <257e0cae-6edd-4c0a-2af3-2bb8bc56827f@intel.com>
References: <20180624084515.10242-1-sasha.neftin@intel.com>
 <cf82084e-aa48-8d00-5ae7-ae53b95f6bb2@oracle.com>
 <257e0cae-6edd-4c0a-2af3-2bb8bc56827f@intel.com>
Message-ID: <c41662df-285e-a243-f017-a0402c43ed9f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/4/2018 6:39 AM, Neftin, Sasha wrote:
> On 6/29/2018 01:25, Shannon Nelson wrote:
>> On 6/24/2018 1:45 AM, Sasha Neftin wrote:

[...]

>>> +
>>> +/**
>>> + *? igc_release_swfw_sync_i225 - Release SW/FW semaphore
>>> + *? @hw: pointer to the HW structure
>>> + *? @mask: specifies which semaphore to acquire
>>> + *
>>> + *? Release the SW/FW semaphore used to access the PHY or NVM.? The 
>>> mask
>>> + *? will also specify which port we're releasing the lock for.
>>> + **/
>>> +void igc_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
>>> +{
>>> +??? u32 swfw_sync;
>>> +
>>> +??? while (igc_get_hw_semaphore_i225(hw))
>>> +??????? ; /* Empty */
>>
>> This loop needs a bounding condition
>>
> I prefer keep and be alight with another drivers. Any benefit if we will 
> change?

When the firmware is "broken" the semaphore get will never succeed and 
the thread will hang.  We shouldn't be creating opportunities for a 
driver to hang a kernel thread.


[...]

>>> ? /**
>>> + *? igc_get_hw_dev - return device
>>> + *? @hw: pointer to hardware structure
>>> + *
>>> + *? used by hardware layer to print debugging information
>>> + **/
>>> +struct net_device *igc_get_hw_dev(struct e1000_hw *hw)
>>> +{
>>> +??? struct igc_adapter *adapter = hw->back;
>>> +
>>> +??? return adapter->netdev;
>>
>> I think this can either become a #define or an inline in a .h file
>>
> Declared in .h Move it will cause to mess. What is benefit move it?

This is a very simple accessor function to get at the netdev, but 
because it is in a separate code file from those that use it, the 
compiler can't optimize it well - there will likely be an expensive 
function call each time it is used.  If it was set up as a "static 
inline" function in a .h file, the compiler can optimize out the 
function call and save a lot of cycles.

sln

