From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 19 Jul 2019 01:47:11 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: add workaround for
 possible stalled packet
In-Reply-To: <20190708045546.30160-1-kai.heng.feng@canonical.com>
References: <20190708045546.30160-1-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D36A9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-07-08 at 12:55 +0800, Kai-Heng Feng wrote:
> Forwardport from http://mails.dpdk.org/archives/dev/2016-November/050657.html
> 
> This works around a possible stalled packet issue, which may occur due to
> clock recovery from the PCH being too slow, when the LAN is transitioning
> from K1 at 1G link speed.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204057
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 10 ++++++++++
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
