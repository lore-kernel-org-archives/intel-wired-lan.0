From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:13:20 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 1/7] ipeh: Create
 exthdrs_options.c and ipeh.h
In-Reply-To: <1566254665-5200-2-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-2-git-send-email-tom@herbertland.com>
Message-ID: <f13f3b65b0a54aa2bc32b8b1164f6e88@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 1/7] ipeh: Create
> exthdrs_options.c and ipeh.h
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Create exthdrs_options.c to hold code related to specific Hop-by-Hop and
> Destination extension header options. Move related functions in exthdrs.c to
> the new file.
> 
> Create include net/ipeh.h to contain common definitions for IP extension
> headers.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h         |  22 +++++
>  include/net/ipv6.h         |   1 +
>  net/ipv6/Makefile          |   2 +-
>  net/ipv6/exthdrs.c         | 204 ---------------------------------------------
>  net/ipv6/exthdrs_options.c | 201
> ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 225 insertions(+), 205 deletions(-)  create mode 100644
> include/net/ipeh.h  create mode 100644 net/ipv6/exthdrs_options.c

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


