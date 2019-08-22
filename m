From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:17:45 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 4/7] ip6tlvs: Registration
 of TLV handlers and parameters
In-Reply-To: <1566254665-5200-5-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-5-git-send-email-tom@herbertland.com>
Message-ID: <6fc3872624214c46811a27a81c13a8c7@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 4/7] ip6tlvs: Registration of TLV
> handlers and parameters
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Create a single TLV parameter table that holds meta information for IPv6
> Hop-by-Hop and Destination TLVs. The data structure is composed of a 256
> element array of u8's (one entry for each TLV type to allow O(1) lookup).
> Each entry provides an offset into an array of TLV proc data structures which
> follows the array of u8s. The TLV proc data structure contains parameters and
> handler functions for receiving and transmitting TLVs. The zeroth element in
> the TLV proc array provides default parameters for TLVs.
> 
> A class attribute indicates the type of extension header in which the TLV may
> be used (e.g. Hop-by-Hop options, Destination options, or Destination
> options before the routing header).
> 
> Functions are defined to manipulate entries in the TLV parameter table.
> 
> * tlv_{set|unset}_proc set a TLV proc entry (ops and parameters)
> * tlv_{set|unset}_params set parameters only
> 
> Receive TLV lookup and processing is modified to be a lookup in the TLV
> parameter table. An init table containing parameters for TLVs supported by
> the kernel is used to initialize the TLV table.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h         | 107 ++++++++++++++++--
>  include/net/ipv6.h         |   3 +
>  include/uapi/linux/ipeh.h  |  16 +++
>  net/ipv6/exthdrs.c         |  14 ++-
>  net/ipv6/exthdrs_common.c  | 271
> +++++++++++++++++++++++++++++++++++++++++----
>  net/ipv6/exthdrs_options.c |  63 +++++++----
>  6 files changed, 421 insertions(+), 53 deletions(-)  create mode 100644
> include/uapi/linux/ipeh.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


