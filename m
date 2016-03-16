From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 16 Mar 2016 15:58:52 -0700
Subject: [Intel-wired-lan] [PATCH V3 net-next] ixgbe: Avoid unaligned
 access in ixgbe_atr() for LLC packets
In-Reply-To: <20160314194716.GM5084@oracle.com>
References: <20160314194716.GM5084@oracle.com>
Message-ID: <1458169132.2878.25.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-03-14 at 15:47 -0400, Sowmini Varadhan wrote:
> 
> For LLC based protocols like lldp, stp etc., the ethernet header
> is an 802.3 header with a h_proto that is not 0x800, 0x86dd, or
> even 0x806.? In this world, the skb_network_header() points at
> the DSAP/SSAP/..? and is not likely to be NET_IP_ALIGNed in
> ixgbe_atr().
> 
> With LLC, drivers are not likely to correctly find IPVERSION,
> or "6", at hdr.ipv4->version, but will instead just needlessly
> trigger an unaligned access. (IPv4/IPv6 over LLC is almost never
> implemented).
> 
> The unaligned access is thus avoidable: bail out quickly after
> examining skb->protocol. The only Ethernet II protocols handled
> are IPv4 and IPv6
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
> v2: Alexander Duyck comments
> v3: filter out all ethertypes? except for Ethernet II and (IPv4 or
> IPv6)
> 
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |??? 5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)

This does not apply since Alex Duyck beat you to the fix. ?Here is the
patch he submitted on 3/15 which corrects the issue. ?So I am dropping
your patch from the queue.

commit 04b8b51c34837765cf6250f69d419c439dc393bf
Author: Alexander Duyck <aduyck@mirantis.com>
Date:???Tue Mar 15 15:10:22 2016 -0700

????ixgbe: Fix ATR so that it correctly handles IPv6 extension headers
????
????The ATR code was assuming that it would be able to use tcp_hdr for
????every TCP frame that came through.??However this isn't the case as
it
????is possible for a frame to arrive that is TCP but sent through
something
????like a raw socket.??As a result the driver was setting up bad
filters in
????which tcp_hdr was really pointing to the network header so the data
was
????all invalid.
????
????In order to correct this I have added a bit of parsing logic that
will
????determine the TCP header location based off of the network header
and
????either the offset in the case of the IPv4 header, or a walk through
the
????IPv6 extension headers until it encounters the header that
indicates
????IPPROTO_TCP.??In addition I have added checks to verify that the
lowest
????protocol provided is recognized as IPv4 or IPv6 to help mitigate
raw
????sockets using ETH_P_ALL from having ATR applied to them.
????
????Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160316/05758d47/attachment.asc>
