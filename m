From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Apr 2016 23:53:01 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 2/3] ixgbe/ixgbevf: Add
 support for GSO partial
In-Reply-To: <20160408210647.13096.55323.stgit@ahduyck-xeon-server>
References: <20160408210103.13096.77973.stgit@ahduyck-xeon-server>
 <20160408210647.13096.55323.stgit@ahduyck-xeon-server>
Message-ID: <1460184781.2982.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-08 at 17:06 -0400, Alexander Duyck wrote:
> This patch adds support for partial GSO segmentation in the case of
> tunnels.? Specifically with this change the driver an perform
> segmenation
> as long as the frame either has IPv6 inner headers, or we are allowed
> to
> mangle the IP IDs on the inner header.? This is needed because we
> will not
> be modifying any fields from the start of the start of the outer
> transport
> header to the start of the inner transport header as we are treating
> them
> like they are just a block of IP options.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c???? |? 105
> +++++++++++++-----
> ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |? 123
> ++++++++++++++++-----
> ?2 files changed, 172 insertions(+), 56 deletions(-)

Dropping this patch (and now the series) because this does not
compile...

[23:51:49 @jtkirshe-linux:next-queue]$ make -j 77 -s
Makefile:679: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is
not supported by compiler
? DESCEND??objtool
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
?ixgbevf_set_features?:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:3892:17: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
? if (features & NETIF_F_TSO_MANGLEID)
?????????????????^
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:3892:17: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
?ixgbevf_probe?:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4062:8: error:
?struct net_device? has no member named ?gso_partial_features?
? netdev->gso_partial_features = IXGBEVF_GSO_PARTIAL_FEATURES;
????????^
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4063:25: error:
?NETIF_F_GSO_PARTIAL? undeclared (first use in this function)
? netdev->hw_features |= NETIF_F_GSO_PARTIAL |
?????????????????????????^
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4073:6: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
??????NETIF_F_TSO_MANGLEID |
??????^
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.o' failed
make[5]: *** [drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.o] Error
1
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel/ixgbevf' failed
make[4]: *** [drivers/net/ethernet/intel/ixgbevf] Error 2
make[4]: *** Waiting for unfinished jobs....
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function
?ixgbe_set_features?:
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8635:17: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
? if (features & NETIF_F_TSO_MANGLEID)
?????????????????^
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8635:17: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function
?ixgbe_probe?:
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9350:8: error: ?struct
net_device? has no member named ?gso_partial_features?
? netdev->gso_partial_features = IXGBE_GSO_PARTIAL_FEATURES;
????????^
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9351:22: error:
?NETIF_F_GSO_PARTIAL? undeclared (first use in this function)
? netdev->features |= NETIF_F_GSO_PARTIAL |
??????????????????????^
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9368:6: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
??????NETIF_F_TSO_MANGLEID |
??????^
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/ixgbe/ixgbe_main.o' failed
make[5]: *** [drivers/net/ethernet/intel/ixgbe/ixgbe_main.o] Error 1
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel/ixgbe' failed
make[4]: *** [drivers/net/ethernet/intel/ixgbe] Error 2
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel' failed
make[3]: *** [drivers/net/ethernet/intel] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net/ethernet'
failed
make[2]: *** [drivers/net/ethernet] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net' failed
make[1]: *** [drivers/net] Error 2
Makefile:962: recipe for target 'drivers' failed
make: *** [drivers] Error 2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160408/ad6b7afd/attachment.asc>
