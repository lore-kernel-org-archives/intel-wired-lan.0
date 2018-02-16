From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 18:51:57 +0200
Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant array
 comparisons to 0 checks
In-Reply-To: <20180215194245.28860-1-colin.king@canonical.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
Message-ID: <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The checks to see if key->dst.s6_addr and key->src.s6_addr are null
> pointers are redundant because these are constant size arrays and
> so the checks always return true.  Fix this by removing the redundant
> checks.

> +               for (i = 0; i < 4; i++)

> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>                                                         cpu_to_be32(0xffffffff);

Can it be one line then?

> +               memcpy(&filter->f.data.tcp_spec.dst_ip,
> +                      &key->dst.s6_addr32,

Ditto.

> +                      sizeof(filter->f.data.tcp_spec.dst_ip));
> +
> +               for (i = 0; i < 4; i++)

> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>                                                         cpu_to_be32(0xffffffff);

Ditto.

> +               memcpy(&filter->f.data.tcp_spec.src_ip,
> +                      &key->src.s6_addr32,

Ditto.

> +                      sizeof(filter->f.data.tcp_spec.src_ip));

-- 
With Best Regards,
Andy Shevchenko
