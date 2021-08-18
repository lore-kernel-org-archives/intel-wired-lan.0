From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 18 Aug 2021 10:05:36 -0700
Subject: [Intel-wired-lan] [RFC net-next 0/7] Add basic SyncE interfaces
In-Reply-To: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210818170536.GE9992@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 06:07:10PM +0200, Arkadiusz Kubalewski wrote:

> The second part can be used to select the port from which the clock
> gets recovered. Each PHY chip can have multiple pins on which the
> recovered clock can be propagated. For example, a SyncE-capable PHY
> can recover the carrier frequency of the first port, divide it
> internally, and output it as a reference clock on PIN 0.

This really sounds like its own thing, and not a PHC at all.

> Next steps:
>  - Add CONFIG_SYNCE definition into Kconfig
>  - Add more configuration interfaces. Aiming at devlink, since this
>    would be device-wide configuration

As a first step, finding an appropriate kernel/user space API would be
needed.

Thanks,
Richard
