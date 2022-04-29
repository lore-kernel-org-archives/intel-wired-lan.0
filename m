From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 29 Apr 2022 16:13:18 +0200
Subject: [Intel-wired-lan] [RFC v2 21/39] net: add HAS_IOPORT
 dependencies
In-Reply-To: <20220429135108.2781579-36-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-36-schnelle@linux.ibm.com>
Message-ID: <20220429141318.qonhkqar2nwyub7d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 29.04.2022 15:50:33, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them. It also turns out that with HAS_IOPORT handled
> explicitly HAMRADIO does not need the !S390 dependency and successfully
> builds the bpqether driver.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/net/can/cc770/Kconfig      | 1 +
>  drivers/net/can/sja1000/Kconfig    | 1 +

For drivers/net/can:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220429/e5fa92f7/attachment-0001.asc>
