From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Thu, 8 Dec 2016 09:21:00 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: fcoe: return value of
	skb_linearize should be handled
In-Reply-To: <1481131804.2404.10.camel@intel.com>
References: <1481096614-25295-1-git-send-email-zhouzhouyi@gmail.com>
 <1481131804.2404.10.camel@intel.com>
Message-ID: <CAABZP2y9arBT2axpU8yP8r_YzoWD8KdUntRMjbNCJiBE7wFwXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Jeff for your advice,
Sorry for the  my innocence as a Linux kernel rookie.

Zhouyi

On Thu, Dec 8, 2016 at 1:30 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2016-12-07 at 15:43 +0800, Zhouyi Zhou wrote:
>> Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
>> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
>> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Reviewed-by: Eric Dumazet <eric.dumazet@gmail.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++++-
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> Did Cong, Yuval and Eric give their Reviewed-by offline?  I see they made
> comments and suggests, but never saw them actually give you their Reviewed-
> by.  You cannot automatically add their Reviewed-by, Signed-off-by, etc
> just because someone provides feedback on your patch.
