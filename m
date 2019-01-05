From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Jan 2019 04:04:24 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Exclude device from
 suspend direct complete optimization
In-Reply-To: <20181211075938.32026-1-kai.heng.feng@canonical.com>
References: <20181211075938.32026-1-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9660FBCD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Kai-Heng Feng
> Sent: Tuesday, December 11, 2018 12:00 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: davem at davemloft.net; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>
> Subject: [PATCH 1/2] e1000e: Exclude device from suspend direct complete
> optimization
> 
> e1000e sets different WoL settings in system suspend callback and
> runtime suspend callback.
> 
> The suspend direct complete optimization leaves e1000e in runtime
> suspneded state with wrong WoL setting during system suspend.
> 
> To fix this, we need to disable suspend direct complete optimization to
> let e1000e always use suspend callback to set correct WoL during system
> suspend.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

