From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:18:19 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 5/7] ip6tlvs: Add TX
 parameters
In-Reply-To: <1566254665-5200-6-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-6-git-send-email-tom@herbertland.com>
Message-ID: <d7a3aebfba9747e89bea95b77d0136f9@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 5/7] ip6tlvs: Add TX
> parameters
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Define a number of transmit parameters for TLV Parameter table definitions.
> These will be used for validating TLVs that are set on a socket.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h         | 18 ++++++++++++++++
>  include/uapi/linux/ipeh.h  |  8 +++++++  net/ipv6/exthdrs_common.c  | 53
> +++++++++++++++++++++++++++++++++++++++++++++-
>  net/ipv6/exthdrs_options.c | 45
> +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


