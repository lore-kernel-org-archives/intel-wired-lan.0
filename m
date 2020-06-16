From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 16 Jun 2020 06:24:34 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add initial LTR support
In-Reply-To: <20200602075047.19085-1-sasha.neftin@intel.com>
References: <20200602075047.19085-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28907C7AAC7843A1236169C4BC9D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Tuesday, June 2, 2020 12:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add initial LTR support
> 
> The LTR message on the PCIe inform the requested latency
> on which the PCIe must become active to the downstream
> PCIe port of the system.
> This patch provide reccommended LTR parameters by i225
> specification.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  27 ++++++++
>  drivers/net/ethernet/intel/igc/igc_i225.c    | 100
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_i225.h    |   1 +
>  drivers/net/ethernet/intel/igc/igc_mac.c     |   5 ++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   6 ++
>  5 files changed, 139 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
