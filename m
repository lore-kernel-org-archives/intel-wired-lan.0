From: tndave <tushar.n.dave@oracle.com>
Date: Fri, 19 May 2017 18:12:27 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: Use le32_to_cpu before
	evaluating HW desc fields.
In-Reply-To: <1494976037.40313.1.camel@intel.com>
References: <1493680559-6728-1-git-send-email-tushar.n.dave@oracle.com>
 <1494976037.40313.1.camel@intel.com>
Message-ID: <8607da8f-51fa-b3e5-2b71-a28863f1fe84@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 05/16/2017 04:07 PM, Jeff Kirsher wrote:
> On Mon, 2017-05-01 at 16:15 -0700, Tushar Dave wrote:
>> i40e hardware descriptor fields are in little-endian format. Driver
>> must use le32_to_cpu while evaluating these fields otherwise on
>> big-endian arch we end up evaluating incorrect values, cause errors
>> like:
>>
>> i40evf 0001:04:02.0: Expected response 0 from PF, received 285212672
>> i40evf 0001:04:02.1: Expected response 0 from PF, received 285212672
>>
>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
>> ---
>>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Due to recent patches already applied to my tree, this patch does not
> apply cleanly.  Feel free to send an updated patch, if the change is
> still needed.
Hi Jeff,

I just tried the same patch on Dave's latest linux-net and it applies
cleanly. Wondering if I should clone your tree and make sure it applies?
If so, I may need to do same for all my future patches as well, thats a
extra bit of work!

Most of the time, mine are bug fixes and I always use linux-net when
upstreaming my patches for Intel Ethernet drivers.

-Tushar
>
