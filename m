From: Steve Douthit <stephend@silicom-usa.com>
Date: Fri, 4 Jan 2019 15:09:32 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not
 a module
In-Reply-To: <f82aa264a695a7719b9a9f6b013bd2686b4a4661.camel@intel.com>
References: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
 <9484abfd-0a07-31be-c738-6b770bbd3dc4@silicom-usa.com>
 <f82aa264a695a7719b9a9f6b013bd2686b4a4661.camel@intel.com>
Message-ID: <afee1791-be69-2cd7-f198-6c84a6d1a4ca@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/3/19 7:55 PM, Jeff Kirsher wrote:
> I initially tried that, but we get a recursive Kconfig dependency error
> when IPSec is enabled as well, which I noted in the commit message.
I'm not running into the dependency issue you mention in my own testing
of the 'select PHYLIB' patch.  All of the following configurations build
for me with no issues:

			0 1 2 3 4 5
CONFIG_IXGBE		m m m m y y
CONFIG_IXGBE_IPSEC	n y n y n y
CONFIG_MDIO_BUS		m m y y y y
CONFIG_PHYLIB		m m y y y y

I also confirmed that I can't have CONFIG_MDIO_BUS=m and CONFIG_IXGBE=y.
Setting CONFIG_IXGBE=y forces CONFIG_MDIO_BUS=y.

Base config I started with is here: https://pastebin.com/yFsiRRQZ
That's the config 0 from above, the only diff to the other configs was
to set the appropriate symbol to 'y'.

I also tested against the config Dave posted (accepting fixdep defaults)
and that also worked.

What am I missing here?

Can you post the config you were using that had the dependency problem
with CONFIG_IXGBE_IPSEC?
