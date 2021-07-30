From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 30 Jul 2021 09:34:17 +0000
Subject: [Intel-wired-lan] [PATCH] ice: fix build issue if
 CONFIG_1588_PTP_CLOCk=m
In-Reply-To: <BN6PR11MB392347CF9B7ACBB94ABDA9168CEC9@BN6PR11MB3923.namprd11.prod.outlook.com>
References: <20210709210726.224848-1-jacob.e.keller@intel.com>
 <BN6PR11MB392347CF9B7ACBB94ABDA9168CEC9@BN6PR11MB3923.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB33677675B74CDAB387793740FCEC9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Saturday, July 10, 2021 2:37 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] ice: fix build issue if
> CONFIG_1588_PTP_CLOCk=m
> 
> If the CONFIG_1588_PTP_CLOCK symbol is set to m, then the driver will not
> compile ice_ptp.o and ice_ptp_hw.o because it adds them to ice-m instead
> of ice-y, and nothing includes ice-m into the final kernel objects.
> 
> Fix this by using the ':m=y' so that we always compile the files and link them
> to ice.o when CONFIG_1588_PTP_CLOCK is a module or a builtin.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> This fixes the compilation errors that have appeared from lkp on Tony's dev-
> queue. The lkp complains about other patches, but the root cause is this
> issue. If we apply this, it should fix all of the lkp issues I've seen so far.
> 
>  drivers/net/ethernet/intel/ice/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> (A Contingent Worker at Intel)
