From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Jun 2015 02:34:19 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/5] e1000e: fix
	flush_desc_ring	implementation
In-Reply-To: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
References: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DDE369@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 02, 2015 7:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/5] e1000e: fix flush_desc_ring
> implementation
> 
> The indication that a descriptor ring flush is required was read from
> FEXTNVM7 by mistake. it should be read from the pci config space.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h   |  2 ++
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 -
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 12 +++++++-----
>  3 files changed, 9 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
