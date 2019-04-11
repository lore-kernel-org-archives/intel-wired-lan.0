From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Apr 2019 22:01:31 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: reduce PTP Tx timestamp
 timeout to 1 second
In-Reply-To: <20190408235202.10676-1-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38D20A@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: reduce PTP Tx timestamp
> timeout to 1 second
> 
> Previously we waited for a whole 15 seconds before we cleared the Tx
> timestamp state. This is astronomically long compared to the worst case
> timings expected by our devices. In addition, this is longer than the wait in
> ptp4l when it detects a fault (caused by missing Tx timestamps).
> Thus, reduce the timer to only 1 second, which is well after the maximum
> expected delay. This should reduce user frustration when a timestamp does
> get dropped for some reason.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


