From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 26 Aug 2015 18:31:51 +0000
Subject: [Intel-wired-lan] [PATCH V5] ixgbe: Add support for VXLAN
	RX	offloads
In-Reply-To: <20150826182933.119479.19081.stgit@mdrustad-wks.jf.intel.com>
References: <20150826182933.119479.19081.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <73A1433A-CEEA-4A52-B642-1A6994FBFD64@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Aug 26, 2015, at 11:29 AM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> 
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

This is intended to replace the single patch with the same name that was in a two-patch series. The only change in this version was to delete a redundant include of net/vxlan.h.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150826/e7f0b458/attachment.asc>
