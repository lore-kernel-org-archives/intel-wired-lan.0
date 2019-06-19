From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 19 Jun 2019 16:55:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/6] etf: Add
 skip_sock_check
In-Reply-To: <3b9b74f4-526e-143e-21a9-ffd841b26bcb@cogentembedded.com>
References: <1560799870-18956-1-git-send-email-vedang.patel@intel.com>
 <1560799870-18956-3-git-send-email-vedang.patel@intel.com>
 <3b9b74f4-526e-143e-21a9-ffd841b26bcb@cogentembedded.com>
Message-ID: <6AA5A401-97AE-47D6-BD0D-2746C4FE3DAE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Sergei for the input.

> On Jun 18, 2019, at 2:28 AM, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
> 
> Hello!
> 
> On 17.06.2019 22:31, Vedang Patel wrote:
> 
>> Currently, etf expects a socket with SO_TXTIME option set for each packet
>> it encounters. So, it will drop all other packets. But, in the future
>> commits we are planning to add functionality which where tstamp value will
>> be set by another qdisc. Also, some packets which are generated from within
>> the kernel (e.g. ICMP packets) do not have any socket associated with them.
>> So, this commit adds support for skip_sock_check. When this option is set,
>> etf will skip checking for a socket and other associated options for all
>> skbs.
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
>> ---
>>  include/uapi/linux/pkt_sched.h |  1 +
>>  net/sched/sch_etf.c            | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
>> index 8b2f993cbb77..69fc52e4d6bd 100644
>> --- a/include/uapi/linux/pkt_sched.h
>> +++ b/include/uapi/linux/pkt_sched.h
>> @@ -990,6 +990,7 @@ struct tc_etf_qopt {
>>  	__u32 flags;
>>  #define TC_ETF_DEADLINE_MODE_ON	BIT(0)
>>  #define TC_ETF_OFFLOAD_ON	BIT(1)
>> +#define TC_ETF_SKIP_SOCK_CHECK  BIT(2)
> 
>  Please indent with a tab like above, not 2 spaces.
> 
I will include this in the next version.

-Vedang
> [...]
> 
> MBR, Sergei

