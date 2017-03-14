From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 14 Mar 2017 02:08:33 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: ixgb: use new
	api	ethtool_{get|set}_link_ksettings
In-Reply-To: <1486336271-25336-1-git-send-email-tremyfr@gmail.com>
References: <1486336271-25336-1-git-send-email-tremyfr@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5B402C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Philippe Reynes
> Sent: Sunday, February 5, 2017 3:11 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Philippe Reynes <tremyfr@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] net: intel: ixgb: use new api
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
>  drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c |   39 ++++++++++++++---------
> -
>  1 files changed, 23 insertions(+), 16 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Well, compile / static tested by:  I probably have an ixgb adapter somewhere as well as a PCI-X slot that might work for it, but am not sure I can find them or that they still function.  If I stumble upon one I'll fire it up and run it through some paces, but the variant of this patch for other drivers seem good and I don't want to hold this patch up any longer.
