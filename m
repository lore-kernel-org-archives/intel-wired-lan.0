From: Patel, Vedang <vedang.patel@intel.com>
Date: Thu, 20 Jun 2019 21:13:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 2/7] etf: Add
 skip_sock_check
In-Reply-To: <c304970a-1973-cdce-17b5-682f28856306@cogentembedded.com>
References: <1560966016-28254-1-git-send-email-vedang.patel@intel.com>
 <1560966016-28254-3-git-send-email-vedang.patel@intel.com>
 <c304970a-1973-cdce-17b5-682f28856306@cogentembedded.com>
Message-ID: <16905BC8-A604-4A74-A9BA-4FCA6F40FE55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Jun 20, 2019, at 1:16 AM, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
> 
> On 19.06.2019 20:40, Vedang Patel wrote:
> 
>> Currently, etf expects a socket with SO_TXTIME option set for each packet
>> it encounters. So, it will drop all other packets. But, in the future
>> commits we are planning to add functionality which where tstamp value will
> 
>   One of "which" and "where", not both. :-)
> 
Yeah. It?s a typo. Will fix it in next version.

Thanks,
Vedang
>> be set by another qdisc. Also, some packets which are generated from within
>> the kernel (e.g. ICMP packets) do not have any socket associated with them.
>> So, this commit adds support for skip_sock_check. When this option is set,
>> etf will skip checking for a socket and other associated options for all
>> skbs.
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> [...]
> 
> MBR, Sergei

