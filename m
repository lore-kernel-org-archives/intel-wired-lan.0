From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Aug 2021 21:46:41 +0200
Subject: [Intel-wired-lan] [RFC net-next 4/7] net: add ioctl interface
 for recover reference clock on netdev
In-Reply-To: <20210816160717.31285-5-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-5-arkadiusz.kubalewski@intel.com>
Message-ID: <CAK8P3a0N3N3mFvoPj_fkqOY30uudJceox=uwSW+nd0B0kf8-ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 6:18 PM Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:

> +/*
> + * Structure used for passing data with SIOCSSYNCE and SIOCGSYNCE ioctls
> + */
> +struct synce_ref_clk_cfg {
> +       __u8 pin_id;
> +       _Bool enable;
> +};

I'm not sure if there are any guarantees about the size and alignment of _Bool,
maybe better use __u8 here as well, if only for clarity.

> +#endif /* _NET_SYNCE_H */
> diff --git a/include/uapi/linux/sockios.h b/include/uapi/linux/sockios.h
> index 7d1bccbbef78..32c7d4909c31 100644
> --- a/include/uapi/linux/sockios.h
> +++ b/include/uapi/linux/sockios.h
> @@ -153,6 +153,10 @@
>  #define SIOCSHWTSTAMP  0x89b0          /* set and get config           */
>  #define SIOCGHWTSTAMP  0x89b1          /* get config                   */
>
> +/* synchronous ethernet config per physical function */
> +#define SIOCSSYNCE     0x89c0          /* set and get config           */
> +#define SIOCGSYNCE     0x89c1          /* get config                   */

I understand that these are traditionally using the old-style 16-bit
numbers, but is there any reason to keep doing that rather than
making them modern like this?

#define SIOCSSYNCE     _IOWR(0x89, 0xc0, struct  synce_ref_clk_cfg)
/* set and get config   */
#define SIOCGSYNCE     _IOR(0x89, 0xc1, struct  synce_ref_clk_cfg)
/* get config   */

        Arnd
