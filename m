From: Stephen Douthit <stephend@silicom-usa.com>
Date: Wed, 12 Jun 2019 21:03:20 +0000
Subject: [Intel-wired-lan] i350 software defined pins sysfs access
In-Reply-To: <C0C7FF38-286F-46CA-909D-1A02EFDBBF0C@flussonic.com>
References: <C0C7FF38-286F-46CA-909D-1A02EFDBBF0C@flussonic.com>
Message-ID: <3827f4b8-506d-f55a-3279-f8a17699ee5e@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/11/19 5:01 PM, Max Lapshin wrote:
> Hi.
> 
> Intel i350 nic has software defined pins. ?I have a custom hardware where these pins are connected to
> some peripheral and I need to enable/disable them.
> 
> Here is patch that enables access to them. I can turn off peripheral device by:
> 
> echo 0 > /sys/class/net/eth1/device/pin2
> 
> and turn on by:
> 
> echo 1 > /sys/class/net/eth1/device/pin2
> 
> Please, give any corrections and advices if this patch requires any changes.
> It is made again git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git? dev-queue

The igb driver already uses these pins for PTP if that's configured and
the 82575 uses SDP3 as a power enable for SFP cages, sgmii PHYs, etc.
You'll need to avoid letting userspace poke at SDPs that the driver is
already using.

Assuming this can coexist with the existing usage, why not register this
as a gpio_chip with the gpiolib framework?

> Subject: [PATCH] i350: Add support for Intel i350 software defined pins
> 
> NIC i350 with igb driver has software defined pins.
> Allow to access them via sysfs files.
> ---
>  ?drivers/net/ethernet/intel/igb/igb.h ? ? ?| ?28 +++++
>  ?drivers/net/ethernet/intel/igb/igb_main.c | 127 +++++++++++++++++++++-
>  ?2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index ca54e268d157..2453674464fa 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -79,6 +79,20 @@ struct igb_adapter;
>  ?#define IGB_I210_RX_LATENCY_1002213
>  ?#define IGB_I210_RX_LATENCY_1000448
> +
> +/* Software defined pins 0-1 */
> +#define IGB_CTRL_SDP0_DATA 0x00040000 /* Value of SW Defineable Pin 0 */
> +#define IGB_CTRL_SDP1_DATA 0x00080000 /* Value of SW Defineable Pin 1 */
> +#define IGB_CTRL_SDP0_DIR ?0x00400000 /* SDP0 Data direction */
> +#define IGB_CTRL_SDP1_DIR ?0x00800000 /* SDP1 Data direction */
> +
> +/* Software defined pins 2-3 */
> +#define IGB_CTRL_EXT_SDP2_DATA E1000_CTRL_EXT_SDP2_DATA /* Value of SW Defineable Pin 2 */
> +#define IGB_CTRL_EXT_SDP3_DATA E1000_CTRL_EXT_SDP3_DATA /* Value of SW Defineable Pin 3 */
> +#define IGB_CTRL_EXT_SDP2_DIR ?E1000_CTRL_EXT_SDP2_DIR ?/* SDP2 Data direction */
> +#define IGB_CTRL_EXT_SDP3_DIR ?E1000_CTRL_EXT_SDP3_DIR ?/* SDP3 Data direction */

Looks like e1000_defines.h already has this info.

-Steve
