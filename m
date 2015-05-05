From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 04 May 2015 19:00:29 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] igb: add i210/i211 external phy
 support
In-Reply-To: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1430791229.2669.205.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-04-30 at 11:19 -0700, Tim Harvey wrote:
> The i210/i211 can use an external phy and there is support built into
> igb
> for several. However if you instead want to use the Linux phydev
> driver API
> the igb driver needs to register an MDIO bus with Linux.
> 
> This patch series fixes mdio read/write capability for i210/i211 and
> registers an MDIO bus if the EEPROM is configured with an external
> phy.
> 
> This has only been tested on an i210 with an external phy as that is
> all I
> have access to. Testing is needed.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Tried to apply your patch series and it does not apply cleanly to my
next-queue tree (dev-queue branch).  Please update your series to my
latest tree and re-submit.

> Tim Harvey (3):
>   net: igb: add i210/i211 support for phy read/write
>   net: igb: add phy read/write functions that accept phy addr
>   net: igb: register mii_bus for SerDes w/ external phy
> 
>  drivers/net/ethernet/intel/igb/e1000_82575.c |  20 +++-
>  drivers/net/ethernet/intel/igb/e1000_hw.h    |   7 ++
>  drivers/net/ethernet/intel/igb/e1000_phy.c   | 137
> +++++++++++++++++-----
>  drivers/net/ethernet/intel/igb/e1000_phy.h   |   6 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    | 163
> ++++++++++++++++++++++++++-
>  5 files changed, 297 insertions(+), 36 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150504/50ff339a/attachment.asc>
