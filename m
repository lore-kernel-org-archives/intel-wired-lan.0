From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 10 Sep 2015 00:59:43 -0700
Subject: [Intel-wired-lan] [PATCH V5] ixgbe: Add support for VXLAN RX
 offloads
In-Reply-To: <20150826182933.119479.19081.stgit@mdrustad-wks.jf.intel.com>
References: <20150826182933.119479.19081.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1441871983.2923.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-08-26 at 11:29 -0700, Mark D Rustad wrote:
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> Add support for VXLAN RX offloads for the X55x devices that support
> them.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V3:
> - change __constant_htons to simply htons
> Changes in V4:
> - add static to ixgbe_clear_vxlan_port
> - use ixgbe_clear_vxlan_port to clear vxlan port
> - call ixgbe_clear_vxlan_port when turning checksum offload off
> Changes in V5:
> - removed redundant include of net/vxlan.h
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |   18 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  116
> ++++++++++++++++++++----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |   15 ++-
>  4 files changed, 124 insertions(+), 31 deletions(-)

Your v4 of this patch was already pushed upstream and accepted, so I am
dropping this patch, as most of it is already upstream.  If the
redundant include still exists, please submit a patch to resolve that
single issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150910/59fec0aa/attachment.asc>
