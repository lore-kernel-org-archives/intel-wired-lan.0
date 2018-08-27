From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 27 Aug 2018 09:07:38 +0300
Subject: [Intel-wired-lan] [PATCH v6 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <77e2a16b-b6e8-0a31-7c85-78186166bd45@oracle.com>
References: <20180823070552.12190-1-sasha.neftin@intel.com>
 <77e2a16b-b6e8-0a31-7c85-78186166bd45@oracle.com>
Message-ID: <fdaccc08-768e-e9ac-3d9b-9ad4efe7fa2e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/23/2018 19:37, Shannon Nelson wrote:
> On 8/23/2018 12:05 AM, Sasha Neftin wrote:
>> This patch adds the beginning framework onto which I am going to add
>> the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
>> Ethernet Controller.
>>
>> Sasha Neftin (v2):
>> update module author, copyright and licence header
>> cosmetic changes
>>
>> Sasha Neftin (v3):
>> remove unused header files
>>
>> Sasha Neftin (v4):
>> update brand name
>> fix syntax by input from community
>> replace e1000_ prefix with igc_ prefix
>>
>> Sasha Neftin (v5):
>> no changes
>>
>> Sasha Neftin (v6):
>> no changes
> 
> In all these patches, this version stuff will be removed from the commit 
> message before pushing upstream, right?
> 
> Normally they appear after the "---" so as to not be a part of the 
> formal commit message saved in git.
> 
> [...]
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h 
>> b/drivers/net/ethernet/intel/igc/igc.h
>> new file mode 100644
>> index 000000000000..afe595cfcf63
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> [...]
> 
>> +MODULE_LICENSE("GPL");
> 
> Since you're using the SPDX "GPL-2.0", you might want to use the 
> MODULE_LICENSE string "GPL v2" to match. since "GPL" means v2 or later. 
> See include/linux/module.h for details.
> 
> By the way, this all looks much nicer with the "igc_" prefix - thanks.
> 
> sln
> Our new drivers, ice, i40e, fm10k used same convention for prefix 
naming. We decided keep igc_ prefix.
Thanks,
Sasha
