From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Apr 2016 23:51:00 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 1/3] i40e/i40evf: Add
 support for GSO partial with UDP_TUNNEL_CSUM and GRE_CSUM
In-Reply-To: <20160408210641.13096.8972.stgit@ahduyck-xeon-server>
References: <20160408210103.13096.77973.stgit@ahduyck-xeon-server>
 <20160408210641.13096.8972.stgit@ahduyck-xeon-server>
Message-ID: <1460184660.2982.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-08 at 17:06 -0400, Alexander Duyck wrote:
> This patch makes it so that i40e and i40evf can use GSO_PARTIAL to
> support
> segmentation for frames with checksums enabled in outer headers.? As
> a
> result we can now send data over these types of tunnels at over
> 20Gb/s
> versus the 12Gb/s that was previously possible on my system.
> 
> The advantage with the i40e parts is that this offload is mostly
> transparent as the hardware still deals with the inner and/or outer
> IPv4
> headers so the IP ID is still incrementing for both when this offload
> is
> performed.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c???? |?? 10 ++++++++--
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.c???? |??? 7 ++++++-
> ?drivers/net/ethernet/intel/i40evf/i40e_txrx.c?? |??? 7 ++++++-
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c |?? 10 ++++++++--
> ?4 files changed, 28 insertions(+), 6 deletions(-)

Dropping this patch because it does not even compile...

[23:49:07 @jtkirshe-linux:next-queue]$ make -j 77 -s
Makefile:679: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is
not supported by compiler
? DESCEND??objtool
drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function
?i40evf_process_config?:
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2354:8: error:
?NETIF_F_GSO_PARTIAL? undeclared (first use in this function)
????????NETIF_F_GSO_PARTIAL??|
????????^
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2354:8: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2361:9: error: ?struct
net_device? has no member named ?gso_partial_features?
???netdev->gso_partial_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
?????????^
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2363:8: error: ?struct
net_device? has no member named ?gso_partial_features?
? netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
????????^
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2367:6: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
??????NETIF_F_TSO_MANGLEID;
??????^
drivers/net/ethernet/intel/i40evf/i40e_txrx.c: In function ?i40e_tso?:
drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1573:37: error:
?SKB_GSO_PARTIAL? undeclared (first use in this function)
???if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
?????????????????????????????????????^
drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1573:37: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/i40evf/i40e_txrx.c: In function
?i40e_tx_enable_csum?:
drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1711:37: error:
?SKB_GSO_PARTIAL? undeclared (first use in this function)
???????!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
?????????????????????????????????????^
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/i40evf/i40evf_main.o' failed
make[5]: *** [drivers/net/ethernet/intel/i40evf/i40evf_main.o] Error 1
make[5]: *** Waiting for unfinished jobs....
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/i40evf/i40e_txrx.o' failed
make[5]: *** [drivers/net/ethernet/intel/i40evf/i40e_txrx.o] Error 1
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel/i40evf' failed
make[4]: *** [drivers/net/ethernet/intel/i40evf] Error 2
make[4]: *** Waiting for unfinished jobs....
drivers/net/ethernet/intel/i40e/i40e_main.c: In function
?i40e_config_netdev?:
drivers/net/ethernet/intel/i40e/i40e_main.c:9127:8: error:
?NETIF_F_GSO_PARTIAL? undeclared (first use in this function)
????????NETIF_F_GSO_PARTIAL??|
????????^
drivers/net/ethernet/intel/i40e/i40e_main.c:9127:8: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/i40e/i40e_main.c:9134:9: error: ?struct
net_device? has no member named ?gso_partial_features?
???netdev->gso_partial_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
?????????^
drivers/net/ethernet/intel/i40e/i40e_main.c:9136:8: error: ?struct
net_device? has no member named ?gso_partial_features?
? netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
????????^
drivers/net/ethernet/intel/i40e/i40e_main.c:9140:6: error:
?NETIF_F_TSO_MANGLEID? undeclared (first use in this function)
??????NETIF_F_TSO_MANGLEID;
??????^
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/i40e/i40e_main.o' failed
make[5]: *** [drivers/net/ethernet/intel/i40e/i40e_main.o] Error 1
make[5]: *** Waiting for unfinished jobs....
drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function ?i40e_tso?:
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2308:37: error:
?SKB_GSO_PARTIAL? undeclared (first use in this function)
???if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
?????????????????????????????????????^
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2308:37: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function
?i40e_tx_enable_csum?:
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2488:37: error:
?SKB_GSO_PARTIAL? undeclared (first use in this function)
???????!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
?????????????????????????????????????^
scripts/Makefile.build:291: recipe for target
'drivers/net/ethernet/intel/i40e/i40e_txrx.o' failed
make[5]: *** [drivers/net/ethernet/intel/i40e/i40e_txrx.o] Error 1
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel/i40e' failed
make[4]: *** [drivers/net/ethernet/intel/i40e] Error 2
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel' failed
make[3]: *** [drivers/net/ethernet/intel] Error 2
make[3]: *** Waiting for unfinished jobs....
scripts/Makefile.build:440: recipe for target 'drivers/net/ethernet'
failed
make[2]: *** [drivers/net/ethernet] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net' failed
make[1]: *** [drivers/net] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:962: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160408/a9d36ed9/attachment.asc>
