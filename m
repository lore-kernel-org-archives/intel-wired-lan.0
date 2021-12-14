From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 14 Dec 2021 09:35:08 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: Use div64_u64 instead
 of div_u64 in adjfine
In-Reply-To: <20211104135211.21315-1-karol.kolacinski@intel.com>
References: <20211104135211.21315-1-karol.kolacinski@intel.com>
Message-ID: <BYAPR11MB3367DB0689D13B4F5570FF02FC759@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karol
> Kolacinski
> Sent: Thursday, November 4, 2021 7:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kolacinski, Karol <karol.kolacinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-next] ice: Use div64_u64 instead of
> div_u64 in adjfine
> 
> Change the division in ice_ptp_adjfine from div_u64 to div64_u64.
> div_u64 is used when the divisor is 32 bit but in this case incval is
> 64 bit and it caused incorrect calculations and incval adjustments.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
