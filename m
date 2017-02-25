From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 25 Feb 2017 02:19:57 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: e1000: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1485011163-7402-1-git-send-email-tremyfr@gmail.com>
References: <1485011163-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5AB2A5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Philippe Reynes
> Sent: Saturday, January 21, 2017 7:06 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Philippe Reynes <tremyfr@gmail.com>
> Subject: [PATCH] net: intel: e1000: use new api
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
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c |   93 +++++++++++---------
> --
>  1 files changed, 46 insertions(+), 47 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
