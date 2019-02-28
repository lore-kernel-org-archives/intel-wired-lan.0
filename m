From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Feb 2019 17:37:29 +0100
Subject: [Intel-wired-lan] [PATCH v3] net: e1000e: add MAC address
 kernel cmd line parameter
In-Reply-To: <b12067de92864d5db83bd3da9456e2fe@asem.it>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch>
 <b12067de92864d5db83bd3da9456e2fe@asem.it>
Message-ID: <20190228163729.GB17912@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Hi Andrew,
> 
> we produce a lot of boards and we have to change the MAC address,
> from u-boot, for every board.  So I must save in the u-boot
> environment (SPI NOR flash) the MAC address for every board.

Hi Flavio

u-boot should be able to write the MAC address in the correct part of
device tree. Boards have been doing this a long time.

Module parameters are considered bad. You should only do it if you
have no other option. Here you do have another options, so it is going
to be a hard sell getting David to access your patch.

You will have more success by adding a call to
eth_platform_get_mac_address() to the e1000e driver.

   Andrew
