From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 18 Sep 2017 08:18:54 -0700
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 1/6] net: Add a new
 socket option for a future transmit time.
In-Reply-To: <ad6e265b97b66bcdb19b815e6d9092ffbcb461ba.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
 <ad6e265b97b66bcdb19b815e6d9092ffbcb461ba.1505719061.git.rcochran@linutronix.de>
Message-ID: <1505747934.29839.21.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-09-18 at 09:41 +0200, Richard Cochran wrote:

> +	case SO_TXTIME:
> +		if (!sock_flag(sk, SOCK_TXTIME))
> +			return -EINVAL;
> +		sockc->transmit_time = *(u64 *)CMSG_DATA(cmsg);

1) No guarantee the CMSG is properly aligned on arches that might trap
on unaligned access.

2) No guarantee user provided 8 bytes here.

Also, what would be the time base here ?

> +		break;
>  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:


