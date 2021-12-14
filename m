From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 14 Dec 2021 09:15:03 +0000
Subject: [Intel-wired-lan] [net-next PATCH v3 9/9] ice: support
 crosstimestamping on E822 devices if supported
In-Reply-To: <20211012213230.2684338-10-jacob.e.keller@intel.com>
References: <20211012213230.2684338-1-jacob.e.keller@intel.com>
 <20211012213230.2684338-10-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB33673F01DDE858004E6C5548FC759@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, October 13, 2021 3:03 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v3 9/9] ice: support
> crosstimestamping on E822 devices if supported
> 
> E822 devices on supported platforms can generate a cross timestamp between
> the platform ART and the device time. This process allows for very precise
> measurement of the difference between the PTP hardware clock and the
> platform time.
> 
> This is only supported if we know the TSC frequency relative to ART, so we do
> not enable this unless the boot CPU has a known TSC frequency (as required by
> convert_art_ns_to_tsc).
> 
> Because PCIe PTM support is not available on all platforms, introduce
> CONFIG_ICE_HWTS and make it depend on X86 where we know the support
> exists.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |  10 ++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 ++
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 117 ++++++++++++++++++
>  3 files changed, 135 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
