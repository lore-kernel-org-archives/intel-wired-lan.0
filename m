From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 9 Oct 2015 15:31:06 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <6607276.TY67sbLLqL@wuerfel>
References: <6607276.TY67sbLLqL@wuerfel>
Message-ID: <20151009153106.000050f6@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 7 Oct 2015 22:13:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Jesse Brandeburg fixed a bug for 32-bit systems in the i40e driver
> in commit 9c70d7cebfec5 ("i40e: fix 32 bit build warnings"), but the
> same code still exists in the i40evf driver and causes compilation
> warnings in ARM and x86 allmodconfig:
> 
> drivers/net/ethernet/intel/i40evf/i40e_common.c:445:68: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/net/ethernet/intel/i40evf/i40e_common.c:446:71: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> This applies the same fix by removing the broken code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for catching that, my mistake.
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

> It would probably be a good idea to merge some of the duplicate code into
> a library module that gets used by both drivers to avoid having to fix bugs
> twice in the future.

The library is a nice idea, but while much of the code is the same,
many things about interaction with it while running in the VF context
are different than when called in the PF context.

We will look closely at what we can commonize and at least move to
header files.

Thanks!
