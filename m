From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 12 Nov 2018 17:17:19 +0530
Subject: [Intel-wired-lan] [RFC] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
Message-ID: <d947edec-8c5a-78d7-4069-687ac4ad7cb8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/12/2018 02:13 PM, Hans Verkuil wrote:
> On 11/12/2018 03:41 AM, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Build tested this with multiple cross compiler options like alpha, sparc,
>> arm64, x86, powerpc64le etc with their default config which might not have
>> compiled tested all driver related changes. I will appreciate folks giving
>> this a test in their respective build environment.
>>
>> All these places for replacement were found by running the following grep
>> patterns on the entire kernel code. Please let me know if this might have
>> missed some instances. This might also have replaced some false positives.
>> I will appreciate suggestions, inputs and review.
> The 'node' in the drivers/media and the drivers/video sources has nothing to
> do with numa. It's an index for a framebuffer instead (i.e. the X in /dev/fbX).

Thanks for the input. Will drop the changes there.
