From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 14 Feb 2019 08:06:04 +0100
Subject: [Intel-wired-lan] i40e XDP - inform user if MTU exceeds
 rx_buf_len when loading program
In-Reply-To: <CAH1YEqHzsuUETUi-P6c75bp1ThNfWAiE4m+wqKW3PXpsgoUJ-Q@mail.gmail.com>
References: <CAH1YEqHzsuUETUi-P6c75bp1ThNfWAiE4m+wqKW3PXpsgoUJ-Q@mail.gmail.com>
Message-ID: <CAJ+HfNgMZEcUB7T2bqXFj6czpQ+Xesj3eBHqr0U8g+0KiqYd1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 25 Jan 2019 at 21:48, Garrett K <gkuchta@gmail.com> wrote:
>
> Hi,
>
> A coworker reached out to me after updating distributions on a lab machine. A previously-working eBFP/XDP program suddenly stopped working, reporting "invalid argument" when attempting to load it with iproute2.
>
> write(2, "RTNETLINK answers: Invalid argum"..., 36RTNETLINK answers: Invalid argument
>
> It looks like their MTU was somehow set to 9000 after the update. Reducing the MTU allowed the program to load.
>
> I _think_ that error was coming from i40e_main.c:i40e_xdp_setup(). If that's the indeed true, and if it's possible, it might be helpful to bubble an error message back up to the user. Maybe something like this?
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index f52e2c46e6a7..134ecbbbb84f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11872,8 +11872,11 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
>         int i;
>
>         /* Don't allow frames that span over multiple buffers */
> -       if (frame_size > vsi->rx_buf_len)
> +       if (frame_size > vsi->rx_buf_len) {
> +               netdev_warn(vsi->netdev, "Frame size %d exceeds rx_buf_len %d; reduce device MTU.\n",
> +                       frame_size, vsi->rx_buf_len);
>                 return -EINVAL;
> +       }
>

Garrett, apologies for the slow get-back.

Indeed, XDP does not currently support all MTUs. Logging the cause of
might be a good idea, but I'd prefer if errors like this were passed
as an "netlink extended ACK report" i.e. via netlink instead of the
kernel ring. This requires more plumbing though.

Other Intel drivers, e.g. ixgbe, has even more XDP constraints and
should probably be reviewed as well.


Cheers,
Bj?rn

> Thank you for the consideration, and apologies if this isn't the right list for this report.
>
> Cheers,
>
> Garrett Kuchta
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
