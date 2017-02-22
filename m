From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 22 Feb 2017 03:27:16 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: e1000e: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1485465593-12561-1-git-send-email-tremyfr@gmail.com>
References: <1485465593-12561-1-git-send-email-tremyfr@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5AA50D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Philippe Reynes
> Sent: Thursday, January 26, 2017 1:20 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Philippe Reynes <tremyfr@gmail.com>
> Subject: [PATCH] net: intel: e1000e: use new api
> ethtool_{get|set}_link_ksettings
> 
> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c |   91 ++++++++++++++---------
> ---
>  1 files changed, 49 insertions(+), 42 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

