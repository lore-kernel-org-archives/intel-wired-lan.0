From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 8 Sep 2020 13:20:15 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <0fb03a39-d098-8fc9-ba70-e919ef8e091e@intel.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
 <82901368-8e17-a63d-0e46-2434b5777c04@molgen.mpg.de>
 <0fb03a39-d098-8fc9-ba70-e919ef8e091e@intel.com>
Message-ID: <0b927a07-6fbb-0e5b-e791-9558c9ea8e63@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Bj?rn,


Am 08.09.20 um 13:12 schrieb Bj?rn T?pel:
> On 2020-09-08 12:12, Paul Menzel wrote:

>> Am 07.09.20 um 17:02 schrieb Bj?rn T?pel:
>>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>>
>>> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
>>> zero-copy path.
>>
>> Could you please add the description from the patch series cover 
>> letter to this commit too? To my knowledge, the message in the cover 
>> letter won?t be stored in the git repository.
> 
> Paul, thanks for the input! The netdev/bpf trees always include the 
> cover letter in the merge commit.

Yes, for pull/merge requests. But you posted them to the list, so I?d 
assume they will be applied with `git am` and not merged, or am I 
missing something. Could you please point me to a merge commit where the 
patches were posted to the list?


Kind regards,

Paul
