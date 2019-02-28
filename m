From: Flavio Suligoi <f.suligoi@asem.it>
Date: Thu, 28 Feb 2019 15:51:40 +0000
Subject: [Intel-wired-lan] [PATCH v3] net: e1000e: add MAC address
 kernel cmd line parameter
In-Reply-To: <20190228153245.GA17912@lunn.ch>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch>
Message-ID: <b12067de92864d5db83bd3da9456e2fe@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: gioved? 28 febbraio 2019 16:33
> To: Flavio Suligoi <f.suligoi@asem.it>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line
> parameter
> 
> On Thu, Feb 28, 2019 at 02:52:31PM +0100, Flavio Suligoi wrote:
> > Sometimes, in some embedded systems boards (i.e. ARM boards),
> > the NVM eeprom is not mounted, to save cost and space.
> >
> > In this case it is necessary to bypass the NVM management
> > and directly force the MAC address using a kernel command-line
> > parameter (macaddr).
> 
> Hi Flavio
> 
> Why not use device tree, since this is an ARM platform?

Hi Andrew,

we produce a lot of boards and we have to change the MAC address, from u-boot, for every board.
So I must save in the u-boot environment (SPI NOR flash) the MAC address for every board.

Flavio
> 
>     Andrew
