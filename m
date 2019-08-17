From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 17 Aug 2019 02:41:03 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add tx_csum offload
 functionality
In-Reply-To: <20190808061223.42725-1-sasha.neftin@intel.com>
References: <20190808061223.42725-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970F74CD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Wednesday, August 7, 2019 11:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Add tx_csum offload functionality
> 
> Add ip generic TX checksum offload functionality.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  4 ++
>  drivers/net/ethernet/intel/igc/igc_base.h    |  8 +++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 97
> ++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
