From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Wed, 4 Aug 2021 15:57:54 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v6 3/4] igc: Enable PCIe PTM
In-Reply-To: <20210727033657.39885-4-vinicius.gomes@intel.com>
References: <20210727033657.39885-1-vinicius.gomes@intel.com>
 <20210727033657.39885-4-vinicius.gomes@intel.com>
Message-ID: <33b1a8ab-f1ca-dce6-57bc-d1d22569376a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/27/2021 06:36, Vinicius Costa Gomes wrote:
> Enables PCIe PTM (Precision Time Measurement) support in the igc
> driver. Notifies the PCI devices that PCIe PTM should be enabled.
> 
> PCIe PTM is similar protocol to PTP (Precision Time Protocol) running
> in the PCIe fabric, it allows devices to report time measurements from
> their internal clocks and the correlation with the PCIe root clock.
> 
> The i225 NIC exposes some registers that expose those time
> measurements, those registers will be used, in later patches, to
> implement the PTP_SYS_OFFSET_PRECISE ioctl().
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
