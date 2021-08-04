From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 4 Aug 2021 17:21:05 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210804142814.GB1645@hoboy.vegasvil.org>
References: <20210804121318.337276-1-arnd@kernel.org>
 <20210804142814.GB1645@hoboy.vegasvil.org>
Message-ID: <CAK8P3a1EBwd+DvqnQSHL03zqaoRz_bhxj6TGw2ivpWLDT7jorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 4, 2021 at 4:28 PM Richard Cochran <richardcochran@gmail.com> wrote:
> > @@ -87,8 +87,8 @@ config E1000E_HWTS
> >  config IGB
> >       tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
> >       depends on PCI
> > -     imply PTP_1588_CLOCK
> > -     select I2C
> > +     depends on PTP_1588_CLOCK_OPTIONAL
> > +     depends on I2C
>
> This little i2c bit sneaks in, but I guess you considered any possible
> trouble with it?

Good catch!

I did need this with v2, as it was causing a circular dependency against
(IIRC) CONFIG_MLXSW_I2C, but I'm fairly sure it's not needed any
more after everything else uses 'depends on' now.

I'm happy to resend a v4 without that change, as it doesn't belong in here,
or we just leave it because it is correct after all, depending on what the Intel
ethernet people prefer.

> Acked-by: Richard Cochran <richardcochran@gmail.com>

Thanks,

      Arnd
