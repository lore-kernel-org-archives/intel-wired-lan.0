From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 29 Dec 2021 15:05:57 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v2] net: don't include
 filter.h from net/sock.h
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
References: <20211229004913.513372-1-kuba@kernel.org>
Message-ID: <20211229140557.cuap5jjqz47yevda@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 28, 2021 at 04:49:13PM -0800, Jakub Kicinski wrote:
>sock.h is pretty heavily used (5k objects rebuilt on x86 after
>it's touched). We can drop the include of filter.h from it and
>add a forward declaration of struct sk_filter instead.
>This decreases the number of rebuilt objects when bpf.h
>is touched from ~5k to ~1k.
>
>There's a lot of missing includes this was masking. Primarily
>in networking tho, this time.
>
>Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba at kernel.org/
> - fix build in bond on ia64
> - fix build in ip6_fib with randconfig

For AF_VSOCK:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

