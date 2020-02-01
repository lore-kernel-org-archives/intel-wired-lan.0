From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Feb 2020 01:58:40 +0000
Subject: [Intel-wired-lan] [PATCH next] igc: make non-global functions
 static
In-Reply-To: <20200108133959.93035-1-chenzhou10@huawei.com>
References: <20200108133959.93035-1-chenzhou10@huawei.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971D2690@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Chen Zhou
> Sent: Wednesday, January 8, 2020 5:40 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; chenzhou10 at huawei.com
> Subject: [PATCH next] igc: make non-global functions static
> 
> Fix sparse warning:
> drivers/net/ethernet/intel/igc/igc_ptp.c:512:6:
> 	warning: symbol 'igc_ptp_tx_work' was not declared. Should it be
> static?
> drivers/net/ethernet/intel/igc/igc_ptp.c:644:6:
> 	warning: symbol 'igc_ptp_suspend' was not declared. Should it be
> static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

