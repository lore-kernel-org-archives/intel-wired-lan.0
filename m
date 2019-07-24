From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jul 2019 22:52:38 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Make speed detection on
 hotplugging cable more reliable
In-Reply-To: <20190715122555.11922-1-kai.heng.feng@canonical.com>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
 <20190715122555.11922-1-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D75A2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-07-15 at 20:25 +0800, Kai-Heng Feng wrote:
> After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
> MII_BMSR may report 10Mbps, renders the network rather slow.
> 
> The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
> Make watchdog use delayed work"), which essentially introduces some
> delay before running the watchdog task.
> 
> But there's still a chance that the hotplugging event and the queued
> watchdog task gets run at the same time, then the original issue can be
> observed once again.
> 
> So let's use mod_delayed_work() to add a deterministic 1 second delay
> before running watchdog task, after an interrupt.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
