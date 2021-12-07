From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 7 Dec 2021 15:25:24 +0100
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix for displaying
 message regarding NVM version
In-Reply-To: <BL1PR11MB52886124AEE0A8C9E6679731876E9@BL1PR11MB5288.namprd11.prod.outlook.com>
References: <20211207132525.26458-1-mateusz.palczewski@intel.com>
 <8e8f07cb-899a-b184-78ed-323d3b436b11@molgen.mpg.de>
 <BL1PR11MB52886124AEE0A8C9E6679731876E9@BL1PR11MB5288.namprd11.prod.outlook.com>
Message-ID: <37f3e44a-cc8b-9632-2982-8b28ac98bbb1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Mateusz,


Am 07.12.21 um 15:23 schrieb Palczewski, Mateusz:

>> Am 07.12.21 um 14:25 schrieb Mateusz Palczewski:
>>> When loading the i40e driver, it prints a message like: 'The driver for the
>>> device detected a newer version of the NVM image v1.x than expected v1.y.
>>> Please install the most recent version of the network driver.' This is
>>> misleading as the driver is working as expected.
>>>
>>> Fix that by removing the second part of message and changing it from
>>> dev_info to dev_dgb.
>>>
>>> Fixes: 4fb29bddb ("i40e: The driver now prints the API version in error message")
>>> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
>>> ---
>>>    v3: Changed the patch after community review
>>>    v2: Fixed the fixes tag to be 12 digits long
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> index 4664d07..c07746b 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> @@ -15469,8 +15469,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>    
>>>    	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
>>>    	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
>>> -		dev_info(&pdev->dev,
>>> -			 "The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u. Please install the most recent version of the network driver.\n",
>>> +		dev_dbg(&pdev->dev,
>>> +			"The driver for the device detected a newer version of the NVM image v%u.%u than expected v%u.%u.\n",
>>>    			 hw->aq.api_maj_ver,
>>>    			 hw->aq.api_min_ver,
>>>    			 I40E_FW_API_VERSION_MAJOR,
>>>
>>
>> It?s a debug message now, so only a few people are going to notice, but
>> a note on what to do to get rid of the message, would be still be nice.
>>
>>> To disable this informational message, update to a newer driver version.
> 
> I believe that, since the driver is working correctly, we shouldn't
> request any action from the user but just to inform about a NVM being
> newer version that expected.

Then ?expected? should also be removed from the message.


Kind regards,

Paul
