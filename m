From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:19:24 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix locking issue
	with	e1000e_disable_aspm
In-Reply-To: <1433888105-30295-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1433888105-30295-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A750A5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:15 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: fix locking issue with
> e1000e_disable_aspm
> 
> e1000e_disable_aspm called pci_disable_link_state_locked which requires
> pci_bus_sem to be held, but is also called from places where this
> semaphore
> was not previously acquired. This patch implements two flavors of
> disable_aspm, one that acquires the lock, and the other (_locked) which
> should be called when the semaphore is already acquired.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 38
> ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
