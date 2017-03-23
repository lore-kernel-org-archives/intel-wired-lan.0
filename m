From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Mar 2017 00:11:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next] e1000: Omit private
	ndo_get_stats function
In-Reply-To: <20170215110811.29976-1-tklauser@distanz.ch>
References: <20170215110811.29976-1-tklauser@distanz.ch>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5CCF4B@ORSMSX101.amr.corp.intel.com>
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
> Subject: [PATCH net-next] e1000: Omit private ndo_get_stats function
> 
> e1000_get_stats() just returns dev->stats so we can leave it
> out altogether and let dev_get_stats() do the job.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
