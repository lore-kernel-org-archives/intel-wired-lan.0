From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 23 Jun 2017 12:44:42 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Remove incorrect ""unexpected
	SYS WRAP" log message
In-Reply-To: <20170623122630.27074-1-vinschen@redhat.com>
References: <20170623122630.27074-1-vinschen@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB58829CF243@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Corinna Vinschen [mailto:vinschen at redhat.com]
> Sent: Friday, June 23, 2017 5:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: sassmann at kpanic.de; Keller, Jacob E <jacob.e.keller@intel.com>;
> jbainbri at redhat.com
> Subject: [PATCH] igb: Remove incorrect ""unexpected SYS WRAP" log message
> 
> TSAUXC.DisableSystime is never set, so SYSTIM runs into a SYS WRAP
> every 1100 secs on 80580/i350/i354 (40 bit SYSTIM) and every 35000
> secs on 80576 (45 bit SYSTIM).
> 
> This wrap event sets the TSICR.SysWrap bit unconditionally.
> 
> However, checking TSIM at interrupt time shows that this event does not
> actually cause the interrupt.  Rather, it's just bycatch while the
> actual interrupt is caused by, for instance, TSICR.TXTS.
> 
> The conclusion is that the SYS WRAP is actually expected, so the
> "unexpected SYS WRAP" message is entirely bogus and just helps to
> confuse users.  Drop it.
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---

This reasoning seems sound to me.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/igb/igb_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 3558ad8..394e77e 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -5746,8 +5746,6 @@ static void igb_tsync_interrupt(struct igb_adapter
> *adapter)
>  		event.type = PTP_CLOCK_PPS;
>  		if (adapter->ptp_caps.pps)
>  			ptp_clock_event(adapter->ptp_clock, &event);
> -		else
> -			dev_err(&adapter->pdev->dev, "unexpected SYS
> WRAP");
>  		ack |= TSINTR_SYS_WRAP;
>  	}
> 
> --
> 2.9.4

