From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 17 May 2016 00:13:42 -0700
Subject: [Intel-wired-lan] [next PATCH S37 05/15] i40evf: report RSS
 hash capability to stack
In-Reply-To: <1463419605-30746-6-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463469222.2649.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-05-16 at 10:26 -0700, Bimmy Pujari wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Set the NETIF_F_RXHASH flag to tell the stack that the device hashes
> packets.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0394366ad8e8bf90bb2815d757a402c39628ccb2
> ---
> Testing Hints : Use ethtool -k to see that the device support receive
> hashing.
> 
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
> ?1 file changed, 1 insertion(+)

Dropping this patch because NETIF_F_RXHASH is already set in this function,
so this patch adds a duplicate flag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160517/e9a6d062/attachment.asc>
