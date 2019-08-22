From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Aug 2019 17:19:16 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 7/7] ip6tlvs: Validation
 of TX Destination and Hop-by-Hop options
In-Reply-To: <1566254665-5200-8-git-send-email-tom@herbertland.com>
References: <1566254665-5200-1-git-send-email-tom@herbertland.com>
 <1566254665-5200-8-git-send-email-tom@herbertland.com>
Message-ID: <47586f3eabf94339b5b74160cc5c7ee8@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 net-next 7/7] ip6tlvs: Validation of TX
> Destination and Hop-by-Hop options
> 
> From: Tom Herbert <tom@quantonium.net>
> 
> Validate Destination and Hop-by-Hop options. This uses the information in
> the TLV parameters table to validate various aspects of both individual TLVs
> as well as a list of TLVs in an extension header.
> 
> There are two levels of validation that can be performed: simple checks and
> deep checks. Simple checks validate only the most basic properties such as
> that the TLV list fits into the EH. Deep checks do a fine grained validation that
> includes perferred ordering, length limits, and length alignment.
> 
> With proper permissions set in the TLV parameter table, this patch allows
> non-privileged users to send TLVs. Given that TLVs are open ended and
> potentially a source of DOS attack, deep checks are performed to limit the
> format that a non-privileged user can send.
> If deep checks are enabled, a canonical format for sending TLVs is enforced
> (in adherence with the robustness principle). A TLV must be well ordered
> with respect to the preferred order for the TLV.
> Each TLV must be aligned as described in the parameter table. Minimal
> padding (one padding TLV) is used to align TLVs. The length of the extension
> header as well as the count of non-padding TLVs is checked against
> max_*_opts_len and max_*_opts_cnt. For individual TLVs, length limits and
> length alignment is checked.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/ipeh.h        |  22 +++
>  net/ipv6/datagram.c       |  51 +++++--
>  net/ipv6/exthdrs_common.c | 382
> ++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/ipv6_sockglue.c  |  39 ++---
>  4 files changed, 455 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


