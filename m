From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 24 May 2022 13:48:33 +0000
Subject: [Intel-wired-lan] [PATCH RESEND] i40e: Remove unnecessary
 synchronize_irq() before free_irq()
In-Reply-To: <20220518213111.2444630-1-anthony.l.nguyen@intel.com>
References: <20220518213111.2444630-1-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367C687414EEDCA02E8566FFCD79@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 19, 2022 3:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zeal Robot <zealci@zte.com.cn>; Minghao Chi
> <chi.minghao@zte.com.cn>
> Subject: [Intel-wired-lan] [PATCH RESEND] i40e: Remove unnecessary
> synchronize_irq() before free_irq()
> 
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Calling synchronize_irq() right before free_irq() is quite useless. On one hand
> the IRQ can easily fire again before free_irq() is entered, on the other hand
> free_irq() itself calls synchronize_irq() internally (in a race condition free
> way), before any state associated with the IRQ is freed.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> Resending due to mail issues with Intel Wired LAN
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
