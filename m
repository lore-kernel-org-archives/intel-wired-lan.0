From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 21 Aug 2021 18:25:52 -0700
Subject: [Intel-wired-lan] [RFC net-next 4/7] net: add ioctl interface
 for recover reference clock on netdev
In-Reply-To: <20210816160717.31285-5-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-5-arkadiusz.kubalewski@intel.com>
Message-ID: <20210822012552.GA4545@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 06:07:14PM +0200, Arkadiusz Kubalewski wrote:

> +/*
> + * Structure used for passing data with SIOCSSYNCE and SIOCGSYNCE ioctls
> + */
> +struct synce_ref_clk_cfg {
> +	__u8 pin_id;

How can the user know what values of 'pin_id' are valid and useful?

> +	_Bool enable;
> +};

Thanks,
Richard
