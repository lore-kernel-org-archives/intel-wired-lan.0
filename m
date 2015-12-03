From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:39:53 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] igb: Remove GS40G
	specific	defines/functions
In-Reply-To: <1446797097.3515.5.camel@intel.com>
References: <624966880.305749.1446575829241.JavaMail.zimbra@xes-inc.com>,
 <1446797097.3515.5.camel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F81@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-11-03 at 12:37 -0600, Aaron Sierra wrote:
> The I210 internal PHY can be accessed just as well with the access
> functions shared by 82580, I350, and I354 devices. A side effect of
> relying on the common functions, is that I210 cable length support
> is folded back into the common case which effectively reverts the
> following commit:
>
>     commit 59f301046b276f87483b3afa3201a4273def06a9
>     Author: Carolyn Wyborny <carolyn.wyborny@intel.com>
>     Date:   Wed Oct 10 04:42:59 2012 +0000
>
>     igb: Update get cable length function for i210/i211
>
> Cc: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 13 ++---
>  drivers/net/ethernet/intel/igb/e1000_i210.c  |? 5 +-
>  drivers/net/ethernet/intel/igb/e1000_i210.h  |? 2 +-
>  drivers/net/ethernet/intel/igb/e1000_phy.c   | 82 +-----------------
> ----------
>  drivers/net/ethernet/intel/igb/e1000_phy.h   | 15 +----
>  5 files changed, 11 insertions(+), 106 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
