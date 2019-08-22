From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:17:13 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 3/7] ipeh: Generic TLV
 parser
In-Reply-To: <1566254665-5200-4-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-4-git-send-email-tom@herbertland.com>
Message-ID: <afca251540de47bd8688907b507285f6@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 3/7] ipeh: Generic TLV parser
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Create a generic TLV parser. This will be used with various extension headers
> that carry options including Destination, Hop-by-Hop, Segment Routing TLVs,
> and other cases of simple stateless parsing.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h        |  25 ++++++++
>  net/ipv6/exthdrs.c        | 159 +++++++++++-----------------------------------
>  net/ipv6/exthdrs_common.c | 114
> +++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+), 121 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


