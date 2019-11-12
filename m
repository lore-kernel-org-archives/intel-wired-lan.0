From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 12 Nov 2019 11:05:38 -0800
Subject: [Intel-wired-lan] [e1000-patches] [PATCH] igb: read flash with
 iomem=strict
In-Reply-To: <0EF347314CF65544BA015993979A29CDB4ED9024@IRSMSX102.ger.corp.intel.com>
References: <0EF347314CF65544BA015993979A29CDB4ED9024@IRSMSX102.ger.corp.intel.com>
Message-ID: <498edf36e634b9590fd7f58fa7febde226bb3e6e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-11-12 at 13:03 +0000, Loktionov, Aleksandr wrote:
> When Secure Boot is enabled access to the /dev/mem is forbidden for user-
> space applications and clients are reporting inability to use tools in
> Secure Boot Mode. The way to perform NVM update is to use igb driver.
> Currently 1G Linux Base Driver has API which allows only EEPROM access.
> There is a need to extend IOCTL API to allow NVM and registers access.
> These defines are necessary for NVM access functions.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---

This patch only adds defines and macros which are not being used in the
driver currently.  It appears you are missing the code to actually use
these defines.  Your missing the changes that Adam made to igb_ethtool.c,
which are currently being reviewed internally.

Since this is an incomplete patch, I will drop it from the queue and will
await a v2 of the patch that has the complete changes needed in the driver.

> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h
> b/drivers/net/ethernet/intel/igb/e1000_defines.h
> index d2e2c50..68dee6a 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
> @@ -481,6 +481,7 @@
>  #define E1000_RAH_POOL_1 0x00040000
>  
>  /* Error Codes */
> +#define E1000_SUCCESS      0
>  #define E1000_ERR_NVM      1
>  #define E1000_ERR_PHY      2
>  #define E1000_ERR_CONFIG   3
> @@ -800,6 +801,37 @@
>  #define NVM_ETS_DATA_INDEX_SHIFT	8
>  #define NVM_ETS_DATA_HTHRESH_MASK	0x00FF
>  
> +#define E1000_REGISTER_SET_SIZE		0x20000 /* CSR Size */
> +#define E1000_FLA	0x0001C  /* Flash Access - RW */
> +#define E1000_FLOP	0x0103C  /* FLASH Opcode Register */
> +#define E1000_I350_BARCTRL		0x5BFC /* BAR ctrl reg */
> +#define E1000_I350_DTXMXPKTSZ		0x355C /* Maximum sent
> packet size reg*/
> +
> +#define E1000_SRWR		0x12018
> +#define E1000_EEC_REG		0x12010
> +
> +#define E1000_SHADOWINF		0x12068
> +#define E1000_FLFWUPDATE	0x12108
> +
> +/* os dep */
> +#define E1000_READ_FLASH_REG(a, reg) (readl((a)->flash_address + 
> +(reg)))
> +
> +#define E1000_READ_FLASH_REG8(a, reg) ( \
> +	readb(READ_ONCE((a)->flash_address) + (reg)))
> +
> +#define E1000_WRITE_FLASH_REG(a, reg, value) ( \
> +	writel((value), ((a)->flash_address + (reg))))
> +
> +#define E1000_READ_REG(x, y) igb_rd32(x, y) #define E1000_READ_REG8(h, 
> +r) readb(READ_ONCE((h)->hw_addr) + (r))
> +
> +#define E1000_WRITE_REG(hw, reg, val) \ do { \
> +	u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
> +	if (!E1000_REMOVED(hw_addr)) \
> +		writel((val), &hw_addr[(reg)]); \
> +} while (0)
> +
>  #define E1000_NVM_CFG_DONE_PORT_0  0x040000 /* MNG config cycle done
> */  #define E1000_NVM_CFG_DONE_PORT_1  0x080000 /* ...for second port
> */  #define E1000_NVM_CFG_DONE_PORT_2  0x100000 /* ...for third port */
> --------------------------------------------------------------------
> 
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII
> Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-
> 07-52-316 | Kapital zakladowy 200.000 PLN.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego
> adresata i moze zawierac informacje poufne. W razie przypadkowego
> otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale
> jej usuniecie; jakiekolwiek
> przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the
> sole use of the intended recipient(s). If you are not the intended
> recipient, please contact the sender and delete all copies; any review or
> distribution by
> others is strictly prohibited.
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191112/f76a71f9/attachment-0001.asc>
