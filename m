From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:13:54 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/7] ipeh: Move generic EH
 functions to exthdrs_common.c
In-Reply-To: <1566254665-5200-3-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-3-git-send-email-tom@herbertland.com>
Message-ID: <faa4b599286e4a76898078e59fa42af5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tom Herbert
> Sent: Monday, August 19, 2019 3:44 PM
> To: Intel-wired-lan at lists.osuosl.org
> Cc: Tom Herbert <tom@herbertland.com>; Tom Herbert
> <tom@quantonium.net>
> Subject: [Intel-wired-lan] [PATCH v3 net-next 2/7] ipeh: Move generic EH
> functions to exthdrs_common.c
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Move generic functions in exthdrs.c to new exthdrs_common.c so that
> exthdrs.c only contains functions that are specific to IPv6 processing, and
> exthdrs_common.c contains functions that are generic. These functions
> include those that will be used with IPv4 extension headers.
> Generic extension header related functions are prefixed by ipeh_.
> 
> Fix kbuild issue.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h        |  12 ++++
>  include/net/ipv6.h        |   9 ---
>  net/dccp/ipv6.c           |   2 +-
>  net/ipv6/Kconfig          |   4 ++
>  net/ipv6/Makefile         |   1 +
>  net/ipv6/calipso.c        |   6 +-
>  net/ipv6/exthdrs.c        | 138 --------------------------------------------
>  net/ipv6/exthdrs_common.c | 144
> ++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/ipv6_sockglue.c  |   2 +-
>  net/ipv6/raw.c            |   2 +-
>  net/ipv6/tcp_ipv6.c       |   2 +-
>  net/ipv6/udp.c            |   2 +-
>  net/l2tp/l2tp_ip6.c       |   2 +-
>  net/sctp/ipv6.c           |   2 +-
>  14 files changed, 171 insertions(+), 157 deletions(-)  create mode 100644
> net/ipv6/exthdrs_common.c

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


