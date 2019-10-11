From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 00:57:52 +0000
Subject: [Intel-wired-lan] [net-next v3 5/7] igb: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-6-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-6-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C829@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Jacob Keller
> Sent: Thursday, September 26, 2019 11:11 AM
> To: netdev at vger.kernel.org
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next v3 5/7] igb: reject unsupported external
> timestamp flags
> 
> Fix the igb PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
