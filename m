From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 04 Jan 2019 10:06:55 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not
 a module
In-Reply-To: <afee1791-be69-2cd7-f198-6c84a6d1a4ca@silicom-usa.com>
References: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
 <9484abfd-0a07-31be-c738-6b770bbd3dc4@silicom-usa.com>
 <f82aa264a695a7719b9a9f6b013bd2686b4a4661.camel@intel.com>
 <afee1791-be69-2cd7-f198-6c84a6d1a4ca@silicom-usa.com>
Message-ID: <331b34610a904d382a1aae4639e646caeacc7bce.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-01-04 at 15:09 +0000, Steve Douthit wrote:
> On 1/3/19 7:55 PM, Jeff Kirsher wrote:
> > I initially tried that, but we get a recursive Kconfig dependency
> > error
> > when IPSec is enabled as well, which I noted in the commit message.
> I'm not running into the dependency issue you mention in my own
> testing
> of the 'select PHYLIB' patch.  All of the following configurations
> build
> for me with no issues:
> 
> 			0 1 2 3 4 5
> CONFIG_IXGBE		m m m m y y
> CONFIG_IXGBE_IPSEC	n y n y n y
> CONFIG_MDIO_BUS		m m y y y y
> CONFIG_PHYLIB		m m y y y y
> 
> I also confirmed that I can't have CONFIG_MDIO_BUS=m and
> CONFIG_IXGBE=y.
> Setting CONFIG_IXGBE=y forces CONFIG_MDIO_BUS=y.
> 
> Base config I started with is here: https://pastebin.com/yFsiRRQZ
> That's the config 0 from above, the only diff to the other configs
> was
> to set the appropriate symbol to 'y'.
> 
> I also tested against the config Dave posted (accepting fixdep
> defaults)
> and that also worked.
> 
> What am I missing here?
> 
> Can you post the config you were using that had the dependency
> problem
> with CONFIG_IXGBE_IPSEC?

I was using 'make allmodconfig' and then altering CONFIG_IXGBE=y to get
the error, but it appears that you are correct.  Using

select PHYLIB
or
imply PHYLIB

does resolve the problem.  I am wondering through all the iterations of
testing, I somehow missed using either of those.  I swore I had tested
those and got this error:

drivers/dma/Kconfig:5:error: recursive dependency detected!
drivers/dma/Kconfig:5:	symbol DMADEVICES is selected by
CRYPTO_DEV_SP_CCP
drivers/crypto/ccp/Kconfig:9:	symbol CRYPTO_DEV_SP_CCP depends on
CRYPTO
crypto/Kconfig:16:	symbol CRYPTO is selected by XFRM_ALGO
net/xfrm/Kconfig:13:	symbol XFRM_ALGO is selected by IXGBE_IPSEC
drivers/net/ethernet/intel/Kconfig:204:	symbol IXGBE_IPSEC depends on
IXGBE
drivers/net/ethernet/intel/Kconfig:158:	symbol IXGBE depends on PHYLIB
drivers/net/phy/Kconfig:181:	symbol PHYLIB is selected by
ARC_EMAC_CORE
drivers/net/ethernet/arc/Kconfig:18:	symbol ARC_EMAC_CORE is
selected by ARC_EMAC
drivers/net/ethernet/arc/Kconfig:24:	symbol ARC_EMAC depends on
OF_IRQ
drivers/of/Kconfig:68:	symbol OF_IRQ depends on IRQ_DOMAIN
kernel/irq/Kconfig:63:	symbol IRQ_DOMAIN is selected by
IRQ_DOMAIN_HIERARCHY
kernel/irq/Kconfig:72:	symbol IRQ_DOMAIN_HIERARCHY is selected by
GENERIC_MSI_IRQ_DOMAIN
kernel/irq/Kconfig:89:	symbol GENERIC_MSI_IRQ_DOMAIN is selected by
MV_XOR_V2
drivers/dma/Kconfig:379:	symbol MV_XOR_V2 depends on DMADEVICES
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

make[2]: *** [scripts/kconfig/Makefile:69: syncconfig] Error 1
make[1]: *** [Makefile:544: syncconfig] Error 2
make: *** [Makefile:640: include/config/auto.conf] Error 2

But now I only get that when I use:

depends on PHYLIB

Since you suggestion is much simply, I will go with your suggestion. 
Expect a v3, with your simplified solution.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190104/2fcb13d3/attachment.asc>
