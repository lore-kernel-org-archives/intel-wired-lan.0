From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 Jul 2016 20:49:03 +0000
Subject: [Intel-wired-lan] [PATCH net] e1000e: fix PTP on
	e1000_pch_lpt	variants
In-Reply-To: <1468959902-25071-1-git-send-email-jarod@redhat.com>
References: <1468959902-25071-1-git-send-email-jarod@redhat.com>
Message-ID: <B2E38BF8-6BB1-4904-B79B-B94B9C360F15@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jarod Wilson <jarod@redhat.com> wrote:

> I've got reports that the Intel I-218V NIC in Intel NUC5i5RYH systems used
> as a PTP slave experiences random ~10 hour clock jumps, which are resolved
> if the same workaround for the 82574 and 82583 is employed. Switching from
> an if to a select, because the list of NIC types could well grow further
> and we'd already have to wrap the conditionals.
>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c  
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 2b2e2f8..866fea0 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4335,7 +4335,10 @@ static cycle_t e1000e_cyclecounter_read(const  
> struct cyclecounter *cc)
>  	systim = (cycle_t)systimel;
>  	systim |= (cycle_t)systimeh << 32;
>
> -	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
> +	switch (hw->mac.type) {
> +	case e1000_82574:
> +	case e1000_82583:
> +	case e1000_pch_lpt:
>  		u64 time_delta, rem, temp;
>  		u32 incvalue;
>  		int i;

I don't think that it is acceptable to declare local variables inside a  
switch statement quite like this. At a minimum, a new block needs to be  
opened to allow the declarations.

> @@ -4360,6 +4363,9 @@ static cycle_t e1000e_cyclecounter_read(const  
> struct cyclecounter *cc)
>  			    (rem == 0))
>  				break;
>  		}
> +		break;
> +	default:
> +		break;
>  	}
>  	return systim;
>  }

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160719/41d052ae/attachment.asc>
