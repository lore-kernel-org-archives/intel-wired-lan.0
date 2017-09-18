From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 18 Sep 2017 16:50:59 +0200
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 1/6] net: Add a new
 socket option for a future transmit time.
In-Reply-To: <ad6e265b97b66bcdb19b815e6d9092ffbcb461ba.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
 <ad6e265b97b66bcdb19b815e6d9092ffbcb461ba.1505719061.git.rcochran@linutronix.de>
Message-ID: <20170918145059.lxaxbsfqen43exam@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 18, 2017 at 09:41:16AM +0200, Richard Cochran wrote:
> diff --git a/arch/powerpc/include/uapi/asm/socket.h b/arch/powerpc/include/uapi/asm/socket.h
> index 3c590c7c42c0..55718129ab06 100644
> --- a/arch/powerpc/include/uapi/asm/socket.h
> +++ b/arch/powerpc/include/uapi/asm/socket.h
> @@ -17,4 +17,7 @@
>  
>  #include <asm-generic/socket.h>
>  
> +#define SO_TXTIME		54
> +#define SCM_TXTIME		SO_TXTIME
> +
>  #endif	/* _ASM_POWERPC_SOCKET_H */

This hunk breaks powerpc builds.  Will fix in the next round...

Thanks,
Richard

