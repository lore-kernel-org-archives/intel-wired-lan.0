From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 9 Aug 2018 19:04:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: VF2VF TCP RSS
In-Reply-To: <20180809094540.29745-1-sebastianx.basierski@intel.com>
References: <20180809094540.29745-1-sebastianx.basierski@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E8B0B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sebastian Basierski
> Sent: Thursday, August 9, 2018 2:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: VF2VF TCP RSS
> 
> While VF2VF with RSS communication, RSS Type were wrongly recognized
> and RSS hash was not calculated as it should be. Packets was distributed on
> various queues by accident.
> This commit fixes that behaviour and causes proper RSS Type recognition.
> 
> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


