From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Jun 2015 02:40:02 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/5] e1000e: fix unit hang
	during	loopback test
In-Reply-To: <0b084820b85c25826686f51a078c5b95fe2dd696.1433253642.git.yanirx.lubetkin@intel.com>
References: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
 <0b084820b85c25826686f51a078c5b95fe2dd696.1433253642.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DDE39D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 02, 2015 7:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 4/5] e1000e: fix unit hang during
> loopback test
> 
> system would hang during execution of "ethtool -t <NIC>" for the same
> reason that required flushing the descriptor rings. this fix disables
> MULR for the loopback test to avoid the hang state.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 27
> ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
