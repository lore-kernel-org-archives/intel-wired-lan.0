From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 28 Oct 2015 00:23:06 +0000
Subject: [Intel-wired-lan] [next-queue v5 06/17] fm10k: Correct typecast
 in	fm10k_update_xc_addr_pf
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EC552A0@ORSMSX105.amr.corp.intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-6-git-send-email-jacob.e.keller@intel.com>
 <804857E1F29AAC47BF68C404FC60A1847EC552A0@ORSMSX105.amr.corp.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E272218ED@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Allan, Bruce W
Sent: Friday, October 16, 2015 4:41 PM
To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [next-queue v5 06/17] fm10k: Correct typecast in fm10k_update_xc_addr_pf

> -----Original Message-----
> From: Intel-wired-lan 
> [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob 
> Keller
> Sent: Friday, October 16, 2015 10:57 AM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v5 06/17] fm10k: Correct 
> typecast in fm10k_update_xc_addr_pf
> 
> Since the resultant data type of the mac_update.mac_upper field is 
> u16, it does not make sense to typecast u8 variables to u32 first. 
> Since we're modifying fm10k_pf.c, also update the copyright year.
> 
> Reported-by: Matthew Vick <matthew.vick@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



