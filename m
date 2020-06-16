From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 16 Jun 2020 07:53:44 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: add ifdef to avoid dead code
In-Reply-To: <20200614061122.35928-1-gthelen@google.com>
References: <20200614061122.35928-1-gthelen@google.com>
Message-ID: <b88dc544-9f1b-75af-244e-9967ffeacf0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/13/20 11:11 PM, Greg Thelen wrote:
> Commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME
> systems") added e1000e_check_me() but it's only called from
> CONFIG_PM_SLEEP protected code.  Thus builds without CONFIG_PM_SLEEP
> see:
>   drivers/net/ethernet/intel/e1000e/netdev.c:137:13: warning: 'e1000e_check_me' defined but not used [-Wunused-function]
> 
> Add CONFIG_PM_SLEEP ifdef guard to avoid dead code.
> 
> Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Greg
