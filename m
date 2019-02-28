From: David Miller <davem@davemloft.net>
Date: Thu, 28 Feb 2019 10:21:43 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH] net: e1000e: add MAC address kernel
 cmd line parameter
In-Reply-To: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
References: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
Message-ID: <20190228.102143.968303356613794513.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Flavio Suligoi <f.suligoi@asem.it>
Date: Thu, 28 Feb 2019 10:20:35 +0100

> Sometimes, in some embedded systems boards (i.e. ARM boards),
> the NVM eeprom is not mounted, to save cost and space.
> 
> In this case it is necessary to bypass the NVM management
> and directly force the MAC address using a kernel command-line
> parameter (macaddr).
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Sorry, we don't do things this way.  Otherwise every single driver would
add a hack like this.

Add either DT or appropriate initrd userland components to achieve
this.

