From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Apr 2019 22:02:28 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: implement support for
 SDP/PPS output on X550 hardware
In-Reply-To: <20190408235202.10676-3-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
 <20190408235202.10676-3-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38D226@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, April 8, 2019 4:52 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: implement support for SDP/PPS
> output on X550 hardware
> 
> Similar to the X540 hardware, enable support for generating a 1pps output
> signal on SDP0.
> 
> This support is slightly different to the X540 hardware, because of the
> register layout changes. First, the system time register is now represented in
> 'cycles' and 'billions of cycles'. Second, we need to also program the TSSDP
> register, as well as the ESDP register. Third, the clock output uses only
> FREQOUT, instead of a full 64bit value for the output clock period. Finally, we
> have to use the ST0 bit instead of the SYNCLK bit in the TSAUXC register.
> 
> This support should work even for the hardware with a higher frequency
> clock, as it carefully takes into account the multiply and shift of the cycle
> counter used.
> 
> We also set the pps configuration to 1, since we now support generating a
> pulse per second output.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 99 ++++++++++++++++++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 14 ++-
>  2 files changed, 108 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


