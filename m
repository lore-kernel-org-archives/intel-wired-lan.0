From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Oct 2019 02:10:54 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for Tiger Lake
In-Reply-To: <20191016080838.25648-1-sasha.neftin@intel.com>
References: <20191016080838.25648-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97154E40@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, October 16, 2019 1:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for Tiger Lake
> 
> Add devices ID's for the next LOM generations that will be
> available on the next Intel Client platform (Tiger Lake)
> This patch provides the initial support for these devices
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 4 +++-
>  drivers/net/ethernet/intel/e1000e/hw.h      | 6 ++++++
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 8 ++++++++
>  drivers/net/ethernet/intel/e1000e/ptp.c     | 2 ++
>  5 files changed, 26 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
