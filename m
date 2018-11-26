From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 26 Nov 2018 11:04:24 -0700
Subject: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
 <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
Message-ID: <4d0840f2-bd96-e671-8120-56ef33a37816@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/26/18 10:56 AM, Jeff Kirsher wrote:
> On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is
>> encoded
>> as -1. Even though implicitly understood it is always better to have
>> macros
>> in there. Replace these open encodings for an invalid node number
>> with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions
>> like
>> 'invalid node' from various places redirecting them to a common
>> definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> For the 'ixgbe' driver changes.
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Lost the original, but for mtip32xx:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

