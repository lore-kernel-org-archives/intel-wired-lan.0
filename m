From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 30 Mar 2017 12:26:02 +0300
Subject: [Intel-wired-lan] [next-queue v6 PATCH 5/7] i40e: Add TX and RX
 support over port netdev's in switchdev mode
In-Reply-To: <1490833375-2788-6-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-6-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAJ3xEMiU-p5nnQSzWDYDsfam+gEK0TnAEz8uB7V7qWMm-fjH8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 30, 2017 at 3:22 AM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> Any frames sent via port netdevs are sent as directed transmits to the
> corresponding VFs.

okay, cool

> In switchdev mode, broadcasts from VFs are received by the PF and passed
> to corresponding port representor netdev.

not following.

If a VF sends a packet and it doesn't match any HW steering rule, then
it has to meet some default rule. Such rule can be fwd to host CPU or drop
or something else.

E.g in mlx5 currently it's fwd to CPU --> the packet is delivered to
the HW queue
of the corresponding VF rep is received into the host networking stack
from there
(the VF rep does netif_rx).

In this series you are not doing any offloading, right? so 100% of the packets
sent by VFs should meet your default rule which I assume you want to be
fwd to host CPU (--> vf rep)

Is that broadcast a special case which will remain in place also when you
add fdb/tc offloading? why not let the HW steering configuration for all types
of traffic be dictated by offloading some SW switching rules?

FWIW - I will not be online till Tues, so will see you reply only then

Or.
