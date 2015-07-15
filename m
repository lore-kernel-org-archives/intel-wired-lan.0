From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 15 Jul 2015 03:30:16 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: Move
 e1000e_disable_aspm_locked() inside CONFIG_PM
In-Reply-To: <1436846075-29366-1-git-send-email-mpe@ellerman.id.au>
References: <1436846075-29366-1-git-send-email-mpe@ellerman.id.au>
Message-ID: <1436956216.13597.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-07-14 at 13:54 +1000, Michael Ellerman wrote:
> e1000e_disable_aspm_locked() is only used in __e1000_resume() which is
> inside CONFIG_PM. So when CONFIG_PM=n we get a "defined but not used"
> warning for e1000e_disable_aspm_locked().
> 
> Move it inside the existing CONFIG_PM block to avoid the warning.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NACK, this is already fixed in my next-queue tree.  Raanan submitted a
patch back on July 6th to resolve this issue, see commit id
a75787d2246a93d256061db602f252703559af65 in my dev-queue branch of my
next-queue tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150715/f6078b62/attachment.asc>
