From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 1 Oct 2015 21:17:45 +0200
Subject: [Intel-wired-lan] [PATCH 03/12] net: igb: avoid using timespec
In-Reply-To: <1443612402-3000775-4-git-send-email-arnd@arndb.de>
References: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
 <1443612402-3000775-4-git-send-email-arnd@arndb.de>
Message-ID: <20151001191745.GC1872@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Arnd

As author of these snippets, I went ahead and reviewed.  I have one
comment, below.

Reviewed-by: Richard Cochran <richardcochran@gmail.com>

On Wed, Sep 30, 2015 at 01:26:33PM +0200, Arnd Bergmann wrote:
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 5982f28d521a..c44df87c38de 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -143,7 +143,7 @@ static void igb_ptp_write_i210(struct igb_adapter *adapter,
>  	 * sub-nanosecond resolution.
>  	 */
>  	wr32(E1000_SYSTIML, ts->tv_nsec);
> -	wr32(E1000_SYSTIMH, ts->tv_sec);
> +	wr32(E1000_SYSTIMH, (u32)ts->tv_sec);

This cast is unnecessary, because wr32 is writel, and that parameter
is a u32.

Thanks,
Richard

>  }
>  
>  /**
