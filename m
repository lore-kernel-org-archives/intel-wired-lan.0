From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 18 Sep 2017 08:14:45 -0700
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 2/6] net: skbuff: Add
 a field to support time based transmission.
In-Reply-To: <555939002f1ca9d89b14f30b3579445e4fa628d9.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
 <555939002f1ca9d89b14f30b3579445e4fa628d9.1505719061.git.rcochran@linutronix.de>
Message-ID: <1505747685.29839.19.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-09-18 at 09:41 +0200, Richard Cochran wrote:
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> ---
>  include/linux/skbuff.h | 2 ++
>  1 file changed, 2 insertions(+)

Why skb->tstamp can not be used ?

AFAIK, fact that it might be overwritten by packet captures should not hurt.



