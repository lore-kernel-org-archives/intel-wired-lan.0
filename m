From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 8 Sep 2020 13:43:22 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <0b927a07-6fbb-0e5b-e791-9558c9ea8e63@molgen.mpg.de>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
 <82901368-8e17-a63d-0e46-2434b5777c04@molgen.mpg.de>
 <0fb03a39-d098-8fc9-ba70-e919ef8e091e@intel.com>
 <0b927a07-6fbb-0e5b-e791-9558c9ea8e63@molgen.mpg.de>
Message-ID: <9d488b02-b03f-e1ee-d4c5-12e330d567b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-08 13:20, Paul Menzel wrote:
[...]>> Paul, thanks for the input! The netdev/bpf trees always include the
>> cover letter in the merge commit.
> 
> Yes, for pull/merge requests. But you posted them to the list, so I?d 
> assume they will be applied with `git am` and not merged, or am I 
> missing something. Could you please point me to a merge commit where the 
> patches were posted to the list?
> 

An example: A series is posted to the list [1], and when merged the 
merge commit look like [2].


Thanks,
Bj?rn


[1] 
https://lore.kernel.org/bpf/20200520192103.355233-1-bjorn.topel at gmail.com/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=79917b242c3fe0d89e4752bc25ffef4574c2194b
