From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 18 Mar 2020 22:32:11 +0000
Subject: [Intel-wired-lan] [PATCH] igc: Fix NFC queue redirection support
In-Reply-To: <20200306235403.18751-1-andre.guedes@intel.com>
References: <20200306235403.18751-1-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B972234BF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, March 6, 2020 3:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igc: Fix NFC queue redirection support
> 
> The support for ethtool Network Flow Classification (NFC) queue
> redirection based on destination MAC address is currently broken in IGC.
> For instance, if we add the following rule, matching frames aren't
> enqueued on the expected rx queue.
> 
> $ ethtool -N IFNAME flow-type ether dst 3c:fd:fe:9e:7f:71 queue 2
> 
> The issue here is due to the fact that igc_rar_set_index() is missing
> code to enable the queue selection feature from Receive Address High
> (RAH) register. This patch adds the missing code and fixes the issue.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++++-
>  drivers/net/ethernet/intel/igc/igc_main.c    | 11 ++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
