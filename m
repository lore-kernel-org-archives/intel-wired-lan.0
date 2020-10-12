From: Coly Li <colyli@suse.de>
Date: Mon, 12 Oct 2020 15:40:27 +0800
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 48/58] drivers/md:
 Utilize new kmap_thread()
In-Reply-To: <20201012052817.GZ2046448@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-49-ira.weiny@intel.com>
 <c802fbf4-f67a-b205-536d-9c71b440f9c8@suse.de>
 <20201012052817.GZ2046448@iweiny-DESK2.sc.intel.com>
Message-ID: <026a7658-6c43-6510-a8b5-32f29de7b281@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020/10/12 13:28, Ira Weiny wrote:
> On Sat, Oct 10, 2020 at 10:20:34AM +0800, Coly Li wrote:
>> On 2020/10/10 03:50, ira.weiny at intel.com wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> These kmap() calls are localized to a single thread.  To avoid the over
>>> head of global PKRS updates use the new kmap_thread() call.
>>>
>>
>> Hi Ira,
>>
>> There were a number of options considered.
>>
>> 1) Attempt to change all the thread local kmap() calls to kmap_atomic()
>> 2) Introduce a flags parameter to kmap() to indicate if the mapping
>> should be global or not
>> 3) Change ~20-30 call sites to 'kmap_global()' to indicate that they
>> require a global mapping of the pages
>> 4) Change ~209 call sites to 'kmap_thread()' to indicate that the
>> mapping is to be used within that thread of execution only
>>
>>
>> I copied the above information from patch 00/58 to this message. The
>> idea behind kmap_thread() is fine to me, but as you said the new api is
>> very easy to be missed in new code (even for me). I would like to be
>> supportive to option 2) introduce a flag to kmap(), then we won't forget
>> the new thread-localized kmap method, and people won't ask why a
>> _thread() function is called but no kthread created.
> 
> Thanks for the feedback.
> 
> I'm going to hold off making any changes until others weigh in.  FWIW, I kind
> of like option 2 as well.  But there is already kmap_atomic() so it seemed like
> kmap_XXXX() was more in line with the current API.

I understand it now, the idea is fine to me.

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li
