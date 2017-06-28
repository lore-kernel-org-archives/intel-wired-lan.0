From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 28 Jun 2017 01:13:09 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Remove incorrect ""unexpected
 SYS	WRAP" log message
In-Reply-To: <20170623122630.27074-1-vinschen@redhat.com>
References: <20170623122630.27074-1-vinschen@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6259F6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Corinna Vinschen
> Sent: Friday, June 23, 2017 5:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: sassmann at kpanic.de; jbainbri at redhat.com
> Subject: [Intel-wired-lan] [PATCH] igb: Remove incorrect ""unexpected SYS
> WRAP" log message
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
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
