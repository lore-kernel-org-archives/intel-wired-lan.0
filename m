From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 24 Sep 2015 13:42:25 -0700
Subject: [Intel-wired-lan] [net PATCH V1] i40e: fix vlan inside vxlan
In-Reply-To: <20150922183432.179418.34423.stgit@jbrandeb-cp2.jf.intel.com>
References: <20150922183432.179418.34423.stgit@jbrandeb-cp2.jf.intel.com>
Message-ID: <1443127345.2987.14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-09-22 at 11:34 -0700, Jesse Brandeburg wrote:
> Previously to this patch, the hardware was removing
> vlan tags from the inner header of vxlan packets.  The
> hardware configuration can be changed to leave the
> packet alone since that is what the linux stack
> expects for this type of vlan in vxlan packet.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

CC: stable <stable@vger.kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150924/f5f12e8b/attachment-0001.asc>
