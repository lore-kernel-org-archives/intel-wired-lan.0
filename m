From: Switzer, David <david.switzer@intel.com>
Date: Fri, 14 Jan 2022 01:04:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] i40e: Disable
 hw-tc-offload feature on driver load.
In-Reply-To: <BL1PR11MB52887B5E0CF12C5E3956607A87789@BL1PR11MB5288.namprd11.prod.outlook.com>
References: <20211216123113.2142-1-mateusz.palczewski@intel.com>
 <253c5cfe-5cac-2eb0-e952-32417efae975@intel.com>
 <BL1PR11MB52887B5E0CF12C5E3956607A87789@BL1PR11MB5288.namprd11.prod.outlook.com>
Message-ID: <SN6PR11MB3518E2C2FA32107CAAB9B974EB549@SN6PR11MB3518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Palczewski, Mateusz
>Sent: Friday, December 17, 2021 2:50 AM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; intel-wired-
>lan at lists.osuosl.org
>Cc: Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>;
>Zulinski, NorbertX <norbertx.zulinski@intel.com>
>Subject: Re: [Intel-wired-lan] [PATCH net-next v3] i40e: Disable hw-tc-offload
>feature on driver load.
>
>>On 12/16/2021 4:31 AM, Mateusz Palczewski wrote:
>>> After loading driver hw-tc-offload is enabled by default.
>>> Change the behaviour of driver to disable hw-tc-offload by default as
>>> this is the expected state. Additionaly since this impacts ntuple
>>> feature state change the way of checking NETIF_F_HW_TC flag.
>>
>>Again, why are you doing this? What's wrong with having it enabled by
>>default? Does a user have to turn it on before programming rules after
>>your change? In order for the maintainers to be interested to apply
>>your patch, you have to explain why it benefits them/kernel/community.
>>
>>> Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
>>> Signed-off-by: Przemyslaw Patynowski
>>> <przemyslawx.patynowski@intel.com>
>>> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
>>
>>Why are there three sign-offs? Did three people work on this patch? If
>>so, did they co-develop it? Three sign-offs in a row would be what's
>>done if you're just handling the patch from one user to another. And in
>>that case, then usually the first person listed would be also credited
>>with the patch upstream by being the From: and set as git author.
>>
>>
>This patch was made as squash of two different ones as requested here:
>https://patchwork.ozlabs.org/project/intel-wired-
>lan/cover/20211213121248.4137-1-mateusz.palczewski at intel.com/
>Since both of the authors of the patches agreed to it in internal review I
>believe that three signed-offs are correct here.
>>> ---
>>>   v3: Removed internal tags and fixed commit message
>>>   v2: Squashed two commits into one
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

