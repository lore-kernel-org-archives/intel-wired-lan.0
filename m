From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:18:44 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 6/7] ip6tlvs: Add netlink
 interface
In-Reply-To: <1566254665-5200-7-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-7-git-send-email-tom@herbertland.com>
Message-ID: <ebcf2bbc00174f4689833278ee1da61c@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 6/7] ip6tlvs: Add netlink
> interface
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Add a netlink interface to manage the TX TLV parameters. Managed
> parameters include those for validating and sending TLVs being sent such as
> alignment, TLV ordering, length limits, etc.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h         |  16 +++
>  include/net/ipv6.h         |   1 +
>  include/uapi/linux/in6.h   |   6 ++
>  include/uapi/linux/ipeh.h  |  29 ++++++  net/ipv6/exthdrs_common.c  | 238
> +++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/exthdrs_options.c |  81 ++++++++++++++-
>  6 files changed, 369 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


