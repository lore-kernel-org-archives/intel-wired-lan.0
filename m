From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 24 Jul 2015 06:18:30 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix incorrect ASPM locking
In-Reply-To: <1436194656-31370-1-git-send-email-raanan.avargil@intel.com>
References: <1436194656-31370-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AC5075@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Raanan Avargil
> Sent: Monday, July 06, 2015 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: Fix incorrect ASPM locking
> 
> This patch fixes wrong locking usage.
> In the context of slot reset, we should use lock.
> And during resume, there is no need of lock.
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
