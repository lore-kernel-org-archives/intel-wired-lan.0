From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 1 Jun 2020 17:08:55 +0000
Subject: [Intel-wired-lan] [PATCH] [net-next] e1000e: fix
 unused-function warning
In-Reply-To: <20200527134716.948148-1-arnd@arndb.de>
References: <20200527134716.948148-1-arnd@arndb.de>
Message-ID: <DM6PR11MB28902EB65134561890C52CB6BC8A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Arnd
> Bergmann
> Sent: Wednesday, May 27, 2020 6:47 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Lifshits, Vitaly
> <vitaly.lifshits@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru>; netdev at vger.kernel.org; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; linux-kernel at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH] [net-next] e1000e: fix unused-function
> warning
> 
> The CONFIG_PM_SLEEP #ifdef checks in this file are inconsistent,
> leading to a warning about sometimes unused function:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:137:13: error: unused function
> 'e1000e_check_me' [-Werror,-Wunused-function]
> 
> Rather than adding more #ifdefs, just remove them completely
> and mark the PM functions as __maybe_unused to let the compiler
> work it out on it own.
> 
> Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

