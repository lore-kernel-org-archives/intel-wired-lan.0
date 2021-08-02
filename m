From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 2 Aug 2021 16:37:32 +0200
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: fix PTP_1588_CLOCK
 dependencies
In-Reply-To: <BYAPR11MB336781A3C6B41DFFFD838157FCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <20210726084540.3282344-1-arnd@kernel.org>
 <BYAPR11MB336781A3C6B41DFFFD838157FCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <CAK8P3a3g60Rg5XxEk+DUUy6pSkSw4TDK7R52Sy6zEVba3O6WsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 2, 2021 at 3:10 PM G, GurucharanX <gurucharanx.g@intel.com> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The 'imply' keyword does not do what most people think it does, it only
> > politely asks Kconfig to turn on another symbol, but does not prevent it from
> > being disabled manually or built as a loadable module when the user is built-
> > in. In the ICE driver, the latter now causes a link failure:
...
> Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> (A Contingent Worker at Intel)

Sorry for the delay. I had remembered that there was a previous discussion
about that option but couldn't find the thread at first.

I now found
https://lore.kernel.org/netdev/CAK8P3a3=eOxE-K25754+fB_-i_0BZzf9a9RfPTX3ppSwu9WZXw at mail.gmail.com/

and will add Richard to Cc for my new version as well, just in case he
has objections
to this version and wants to fix it differently.

       Arnd
