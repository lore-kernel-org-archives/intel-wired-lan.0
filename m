From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Tue, 16 Jun 2020 21:20:07 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: add ifdef to avoid dead code
In-Reply-To: <b88dc544-9f1b-75af-244e-9967ffeacf0e@gmail.com>
References: <20200614061122.35928-1-gthelen@google.com>
 <b88dc544-9f1b-75af-244e-9967ffeacf0e@gmail.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D940449871E142@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Eric Dumazet <eric.dumazet@gmail.com>
> On 6/13/20 11:11 PM, Greg Thelen wrote:
> > Commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME
> > systems") added e1000e_check_me() but it's only called from
> > CONFIG_PM_SLEEP protected code.  Thus builds without CONFIG_PM_SLEEP
> > see:
> >   drivers/net/ethernet/intel/e1000e/netdev.c:137:13: warning:
> > 'e1000e_check_me' defined but not used [-Wunused-function]
> >
> > Add CONFIG_PM_SLEEP ifdef guard to avoid dead code.
> >
> > Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME
> > systems")
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
[Kirsher, Jeffrey T] 

This patch is not necessary, after Arnd's patch.  Here is his patch:
http://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200527134716.948148-1-arnd at arndb.de/
 and I will be pushing it to Dave's net tree later tonight.
