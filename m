From: Laatz, Kevin <kevin.laatz@intel.com>
Date: Tue, 25 Jun 2019 14:14:59 +0100
Subject: [Intel-wired-lan] [PATCH 03/11] xdp: add offset param to
 zero_copy_allocator
In-Reply-To: <20190624122342.26c6a9b4@cakuba.netronome.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190620090958.2135-4-kevin.laatz@intel.com>
 <20190624122342.26c6a9b4@cakuba.netronome.com>
Message-ID: <bf3e67de-b23a-fa69-4cbc-c53e9cc5e055@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 24/06/2019 20:23, Jakub Kicinski wrote:
> On Thu, 20 Jun 2019 09:09:50 +0000, Kevin Laatz wrote:
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index 0f25b3675c5c..ea801fd2bf98 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -53,7 +53,8 @@ struct xdp_mem_info {
>> ?struct page_pool;
>>
>> ?struct zero_copy_allocator {
>> -??? void (*free)(struct zero_copy_allocator *zca, unsigned long 
>> handle);
>> +??? void (*free)(struct zero_copy_allocator *zca, unsigned long handle,
>> +??????????? off_t off);
>> ?};
>
> Please run checkpatch --strict on all your changes.? The code
> formatting is incorrect in many ways in this series.
>
Thanks, will fix in the v2.


> Please include performance measurements proving the slow down
> is negligible in the cover letter.
>
Good suggestion. Will add to the cover letter in the v2!
