From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Jan 2016 00:25:42 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: constify ixgbe_mbx_operations
	structure
In-Reply-To: <1451804129-32213-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1451804129-32213-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1452241542.19358.30.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2016-01-03 at 07:55 +0100, Julia Lawall wrote:
> This ixgbe_mbx_operations structure is never modified, so declare it
> as
> const.? The other structure of this type is already const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c? |??? 2 +-
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h? |??? 2 +-
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |??? 2 +-
> ?3 files changed, 3 insertions(+), 3 deletions(-)

Dropping this patch since Mark has provided a more in-depth patch to
fix the entire driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160108/ea425693/attachment-0001.asc>
