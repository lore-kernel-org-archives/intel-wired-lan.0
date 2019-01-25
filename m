From: Garrett K <gkuchta@gmail.com>
Date: Fri, 25 Jan 2019 14:48:09 -0600
Subject: [Intel-wired-lan] i40e XDP - inform user if MTU exceeds rx_buf_len
 when loading program
Message-ID: <CAH1YEqHzsuUETUi-P6c75bp1ThNfWAiE4m+wqKW3PXpsgoUJ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

A coworker reached out to me after updating distributions on a lab machine.
A previously-working eBFP/XDP program suddenly stopped working, reporting
"invalid argument" when attempting to load it with iproute2.

write(2, "RTNETLINK answers: Invalid argum"..., 36RTNETLINK answers:
Invalid argument

It looks like their MTU was somehow set to 9000 after the update. Reducing
the MTU allowed the program to load.

I _think_ that error was coming from i40e_main.c:i40e_xdp_setup(). If
that's the indeed true, and if it's possible, it might be helpful to bubble
an error message back up to the user. Maybe something like this?

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f52e2c46e6a7..134ecbbbb84f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11872,8 +11872,11 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
        int i;

        /* Don't allow frames that span over multiple buffers */
-       if (frame_size > vsi->rx_buf_len)
+       if (frame_size > vsi->rx_buf_len) {
+               netdev_warn(vsi->netdev, "Frame size %d exceeds rx_buf_len
%d; reduce device MTU.\n",
+                       frame_size, vsi->rx_buf_len);
                return -EINVAL;
+       }

Thank you for the consideration, and apologies if this isn't the right list
for this report.

Cheers,

Garrett Kuchta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190125/919a84df/attachment.html>
