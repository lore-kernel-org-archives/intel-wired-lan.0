From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Aug 2021 22:29:52 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
Message-ID: <CAK8P3a1tKjWo6RQq9nxDAuEWyEF=p8HDBzYG+=r3HVG9k0oUEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 2, 2021 at 10:32 PM Arnd Bergmann <arnd@kernel.org> wrote:

> config MAY_USE_PTP_1588_CLOCK
>        def_tristate PTP_1588_CLOCK || !PTP_1588_CLOCK
>
>  config E1000E
>         tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
>         depends on PCI && (!SPARC32 || BROKEN)
> +       depends on MAY_USE_PTP_1588_CLOCK
>         select CRC32
> -       imply PTP_1588_CLOCK

I've written up the patch to do this all over the kernel now, and started an
overnight randconfig build session with this applied:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=ptp-1588-optional&id=3f69b7366cfd4b2c048c76be5299b38066933ee1

       Arnd
