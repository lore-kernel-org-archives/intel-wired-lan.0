From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 18 Jan 2018 09:10:59 -0800
Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: add unlikely
 notes to tx fastpath expressions
In-Reply-To: <6322a15f-693f-4056-164b-82012714d1e0@oracle.com>
References: <1515451669-927-1-git-send-email-shannon.nelson@oracle.com>
 <1515451669-927-2-git-send-email-shannon.nelson@oracle.com>
 <6322a15f-693f-4056-164b-82012714d1e0@oracle.com>
Message-ID: <acce7bd3-ce04-0279-6ca3-99404363bd4d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/18/2018 1:06 AM, Yanjun Zhu wrote:
> On 2018/1/9 6:47, Shannon Nelson wrote:
>> Add unlikely() to a few error checking expressions in the Tx
>> offload handling.
>>
>> Suggested-by: Yanjun Zhu <yanjun.zhu@oracle.com>
> Hi,
> 
> I am fine with this patch. I have a question. The ipsec feature is 
> supported in ixgbevf?

The x540 datasheet doesn't show any IPsec registers in the VF space, so 
I'm pretty sure the answer is 'no'.

One of the difficulties in providing this is how to manage the register 
space needed in the chip.  Either there's one big table that the PF and 
all the VFs need to somehow coordinate to share, or there are separate 
tables for each PF and VF, taking up a lot of chip space.  I suspect the 
original 82599 designers just weren't ready to take on this issue, nor 
was there enough customer pull in the VF space yet for such a thing.

sln

> 
> Thanks a lot.
> Zhu Yanjun

