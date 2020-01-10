From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 10 Jan 2020 00:21:41 +0000
Subject: [Intel-wired-lan] [net v2] e1000e: Revert "e1000e: Make
 watchdog use delayed work"
In-Reply-To: <20200105072922.3810260-1-jeffrey.t.kirsher@intel.com>
References: <20200105072922.3810260-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971A9B76@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff
> Kirsher
> Sent: Saturday, January 4, 2020 11:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net v2] e1000e: Revert "e1000e: Make watchdog use
> delayed work"
> 
> This reverts commit 59653e6497d16f7ac1d9db088f3959f57ee8c3db.
> 
> This is due to this commit causing driver crashes and connections to
> reset unexpectedly.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: fix the partial revert of Alex Duyck's patch to remove the use of
>     __E1000_DOWN bit
> 
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  5 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c | 54 ++++++++++------------
>  2 files changed, 27 insertions(+), 32 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
