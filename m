From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 28 Aug 2018 09:08:16 +0300
Subject: [Intel-wired-lan] [PATCH v6 03/11] igc: Add netdev
In-Reply-To: <1090b26f-cd49-72c3-efed-c977a9b2fab6@intel.com>
References: <20180823070557.12312-1-sasha.neftin@intel.com>
 <54a5282f-df2e-378c-fdb6-124ef2bcd3b6@oracle.com>
 <1090b26f-cd49-72c3-efed-c977a9b2fab6@intel.com>
Message-ID: <5e69fa57-55f6-f0d9-20af-d95c70e28eb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/27/2018 10:42, Neftin, Sasha wrote:
> On 8/23/2018 19:37, Shannon Nelson wrote:
>> On 8/23/2018 12:05 AM, Sasha Neftin wrote:
>>
>> [...]
>>
>>> +??? strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
>>
>> [...]
>>
>>> +??? strncpy(netdev->name, "eth%d", IFNAMSIZ);
>>
>> I've mentioned this to you before: why are you setting the 
>> netdev->name twice, and to different values?? Besides, the OS's udev 
>> rules will likely change the name to something else.
>>
> I believe I already answered in previous review (v3 or v4). Since I 
> remove second settings of netdev->name: "strncpy(netdev->name, "eth%d", 
> IFNAMSIZ)" I got error in probe: "probe of 0000:05:00.0 failed with 
> error -22". I agree with you that we can do some optimization here - I 
> will look later again in this code.
>>
Thanks that you point me on this. I figure out that 
'strncpy(netdev->name, pci_name(pdev)...' line have no point and should 
be removed. Since v6 should be final I will consult with Jeff how to 
submit change, probably in different patch. Also, we need run validation 
cycle.
>>> +
>>> +module_param(debug, int, 0);
>>> +MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>>> ? /* igc_main.c */
>>
>> It would be nice to have this up above, next to the definition of int 
>> debug.
>>
> so, may be all code start from MODULE_AUTHOR... move to begin of the 
> file. it is not urgent. I will look at other examples. what is benefit 
> from this?
>> sln
>>
> Sasha
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

