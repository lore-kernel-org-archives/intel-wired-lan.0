From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Oct 2015 23:18:21 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <6607276.TY67sbLLqL@wuerfel>
References: <6607276.TY67sbLLqL@wuerfel>
Message-ID: <1444717101.2870.16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-07 at 22:13 +0200, Arnd Bergmann wrote:
> Jesse Brandeburg fixed a bug for 32-bit systems in the i40e driver
> in commit 9c70d7cebfec5 ("i40e: fix 32 bit build warnings"), but the
> same code still exists in the i40evf driver and causes compilation
> warnings in ARM and x86 allmodconfig:
> 
> drivers/net/ethernet/intel/i40evf/i40e_common.c:445:68: warning: cast
> from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/net/ethernet/intel/i40evf/i40e_common.c:446:71: warning: cast
> from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> This applies the same fix by removing the broken code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Does not apply at all to my next-queue tree (dev-queue branch), my
guess is that this is already fixed in one of the patches already in my
queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151012/7a2244b7/attachment.asc>
