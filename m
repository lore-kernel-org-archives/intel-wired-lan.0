From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 5 Nov 2021 12:20:41 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix issue when maximum
 queues is exceeded
In-Reply-To: <DM6PR11MB27311D49882F8D48EF3F9874F08E9@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20210823114344.7058-1-jedrzej.jagielski@intel.com>
 <2e3f1249-a62e-3829-a17b-46284174dc29@molgen.mpg.de>
 <DM6PR11MB27311D49882F8D48EF3F9874F08E9@DM6PR11MB2731.namprd11.prod.outlook.com>
Message-ID: <f3e3b568-c239-fc5e-b30f-63d3c16e8191@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jedrzej,


On 05.11.21 12:12, Jagielski, Jedrzej wrote:

[?]

>> On 23.08.21 13:43, Jedrzej Jagielski wrote:
>>
>> Maybe use:
>>
>> i40e: Handle case of depleted

Sorry, I didn?t finish that. Maybe:

i40e: Handle case of using more than available queues

> Is the title of the patch connected to the mailing
> thread? I am afraid that if I change the title
> the mailing thread won't be coherent.

Yes, that is what I meant. I guess if you tag it v2, the tooling like 
Patchwork might be able to figure it out.

>>> Before this patch VF interface vanished when maximum queue
>>> number was exceeded. Driver tried to add next queues even
>>> if there was not enough space. PF sent incorrect number of
>>> queues to the VF when there were not enough of them.
>>>
>>> Add an additional condition introduced to check
>>> available space in 'qp_pile' before proceeding.
>>> Also add the search for free space in PF queue pair piles.
>>
>> Please reflow for 75 characters per line.
>>
>> How is the new search better?
>>
>>> Without this patch VF interfaces are not seen when available
>>> space for queues has been exceeded and following logs appears
>>> permanently in dmesg:
>>> "Unable to get VF config (-32)".
>>> "VF 62 failed opcode 3, retval: -5"
>>> "Unable to get VF config due to PF error condition, not retrying"
>>
>> Please add the new logs.
> 
> What logs do you mean?

Your patch adds:

+		dev_warn(&pf->pdev->dev,
+			 "VF %d requested %d more queues, but there is not enough for it.\n",
+			 vf->vf_id,
+			 req_pairs - cur_pairs);

[?]


Kind regards,

Paul
