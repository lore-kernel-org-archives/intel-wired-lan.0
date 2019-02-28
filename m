From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Feb 2019 16:32:45 +0100
Subject: [Intel-wired-lan] [PATCH v3] net: e1000e: add MAC address
 kernel cmd line parameter
In-Reply-To: <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
Message-ID: <20190228153245.GA17912@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 28, 2019 at 02:52:31PM +0100, Flavio Suligoi wrote:
> Sometimes, in some embedded systems boards (i.e. ARM boards),
> the NVM eeprom is not mounted, to save cost and space.
> 
> In this case it is necessary to bypass the NVM management
> and directly force the MAC address using a kernel command-line
> parameter (macaddr).

Hi Flavio

Why not use device tree, since this is an ARM platform?

    Andrew
