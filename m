From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 28 Jun 2019 03:21:45 +0000
Subject: [Intel-wired-lan] [PATCH v3] e1000e: Make watchdog use delayed
 work
In-Reply-To: <20190623031437.19716-1-detlev.casanova@gmail.com>
References: <20190623031437.19716-1-detlev.casanova@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B54AA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Detlev Casanova
> Sent: Saturday, June 22, 2019 8:15 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Detlev Casanova <detlev.casanova@gmail.com>
> Subject: [PATCH v3] e1000e: Make watchdog use delayed work
> 
> Use delayed work instead of timers to run the watchdog of the e1000e
> driver.
> 
> Simplify the code with one less middle function.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  5 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c | 54 ++++++++++++----------
>  2 files changed, 32 insertions(+), 27 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
