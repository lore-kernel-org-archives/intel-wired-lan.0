From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 24 Mar 2017 22:08:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgb: Omit private
	ndo_get_stats function
In-Reply-To: <20170215110820.30052-1-tklauser@distanz.ch>
References: <20170215110820.30052-1-tklauser@distanz.ch>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5DDEA1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Tobias Klauser
> Sent: Wednesday, February 15, 2017 3:08 AM
> To: netdev at vger.kernel.org
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; Joe Perches <joe@perches.com>
> Subject: [PATCH net-next] ixgb: Omit private ndo_get_stats function
> 
> ixgb_get_stats() just returns dev->stats so we can leave it
> out altogether and let dev_get_stats() do the job.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Well, well.  I managed to locate one of my ixgb based adapters as well as a system with a working PCI-X bus to host it.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
