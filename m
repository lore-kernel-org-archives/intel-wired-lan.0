From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Apr 2019 22:02:02 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: fix PTP SDP pin setup on
 X540 hardware
In-Reply-To: <20190408235202.10676-2-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
 <20190408235202.10676-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38D219@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/5] ixgbe: fix PTP SDP pin setup on X540
> hardware
> 
> The function ixgbe_ptp_setup_sdp_X540 attempts to program a software
> defined pin, in order to generate a pulse-per-second output on SDP 0.
> 
> It does work to generate the output, but does not align the output on the full
> second. Additionally, it does not take into account the cyclecounter
> multiplier. This leads to somewhat confusing code which is likely to be
> incorrect if blindly copied to another hardware type.
> 
> Update this code to account for the cyclecounter multiplier, and to directly
> use timecounter_read.
> 
> This change ensures that the SDP output will align properly on a full second,
> and makes the intent of the calculations a bit more clear.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 71 ++++++++++++--------
>  1 file changed, 42 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


