From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 6 May 2016 23:43:17 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: prevent division by zero
	if	TIMINCA is zero
In-Reply-To: <1462563711-30350-1-git-send-email-dvlasenk@redhat.com>
References: <1462563711-30350-1-git-send-email-dvlasenk@redhat.com>
Message-ID: <5E18E4A4-E10F-46B5-A2F5-FCA10FAA5030@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Denys Vlasenko <dvlasenk@redhat.com> wrote:

> Users report that under VMWare, er32(TIMINCA) returns zero.
> This causes division by zero at init time as follows:
>
>  ==>            incvalue = er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK;
>                 for (i = 0; i < E1000_MAX_82574_SYSTIM_REREADS; i++) {
>                         /* latch SYSTIMH on read of SYSTIML */
>                         systim_next = (cycle_t)er32(SYSTIML);
>                         systim_next |= (cycle_t)er32(SYSTIMH) << 32;
>
>                         time_delta = systim_next - systim;
>                         temp = time_delta;
>  ====>                  rem = do_div(temp, incvalue);
>
> This change makes kernel survive this, and users report that
> NIC does work after this change.
>
> Since on real hardware incvalue is never zero, this should not affect
> real hardware use case.
>
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> CC: LKML <linux-kernel@vger.kernel.org>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c  
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 269087c..0626935 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4315,7 +4315,8 @@ static cycle_t e1000e_cyclecounter_read(const  
> struct cyclecounter *cc)
>
>  			time_delta = systim_next - systim;
>  			temp = time_delta;
> -			rem = do_div(temp, incvalue);
> +			/* VMWare users have seen incvalue of zero, don't div / 0 */
> +			rem = incvalue ? do_div(temp, incvalue) : (time_delta != 0);
>
>  			systim = systim_next;
>

I seem to recall that this was rejected before because it really is  
VMWare's bug and, if they fix it, any existing VMs that use this will just  
work. Changing the driver will only fix it for vms that install a new  
driver. I don't object to doing it, it just seems like not the most  
effective place to address the issue.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160506/ba2d808c/attachment.asc>
