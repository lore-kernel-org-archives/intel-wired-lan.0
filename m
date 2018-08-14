From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 14 Aug 2018 08:30:19 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 0/8] ixgbe/ixgbevf: IPsec
 offload support for VFs
In-Reply-To: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0UdcijJ4f4gKeHj6t_EGuKjE7P5oZ0UH0_jfuHQ05RJALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 13, 2018 at 11:43 AM Shannon Nelson
<shannon.nelson@oracle.com> wrote:
>
> This set of patches implements IPsec hardware offload for VF devices in
> Intel's 10Gbe x540 family of Ethernet devices.
>
> The IPsec HW offload feature has been in the x540/Niantic family of
> network devices since their release in 2009, but there was no Linux
> kernel support for the offload until 2017.  After the XFRM code added
> support for the offload last year, the hw offload was added to the ixgbe
> PF driver.
>
> Since the related x540 VF device uses same setup as the PF for implementing
> the offload, adding the feature to the ixgbevf seemed like a good idea.
> In this case, the PF owns the device registers, so the VF simply packages
> up the request information into a VF<->PF message and the PF does the
> device configuration.  The resulting IPsec throughput is roughly equivalent
> to what we see in the PF - nearly line-rate, with the expected drop in CPU
> cycles burned.  (I'm not great at performance statistics, I'll let better
> folks do the actual measurements as they pertain to their own usage)
>
> To make use of the capability, first two things are needed: the PF must
> be told to enable the offload for VFs (it is off by default) and the VF
> must be trusted.  A new ethtool priv-flag for ixgbe is added to control
> VF offload support.  For example:
>
>         ethtool --set-priv-flags eth0 vf-ipsec on
>         ip link set eth0 vf 1 trust on
>
> Once those are set up and the VF device is UP, the user can add SAs the
> same as for PFs, whether the VF is in the host or has been assigned to
> a VM.
>
> Note that the x540 chip supports a total of 1024 Rx plus 1024 Tx Security
> Associations (SAs), shared among the PF and VFs that might request them.
> It is entirely possible for a single VF to soak up all the offload
> capability, which would likely annoy some people.  It seems rather
> arbitrary to try to set a limit for how many a VF could be allowed,
> but this is mitigated somewhat by the need for "trust" and "vf-ipsec"
> to be enabled.  I suppose we could come up with a way to make a limit
> configurable, but there is no existing method for adding that kind
> configuration so I'll leave that to a future discussion.
>
> Currently this doesn't support Tx offload as the hardware encryption
> engine doesn't seem to engage on the Tx packets.  This may be a lingering
> driver bug, more investigation is needed.  Until then, requests for a Tx
> offload are failed and the userland requester will need to add Tx SAs
> without the offload attribute.
>
> Given that we don't have Tx offload support, the benefit here is less
> than it could be, but is definitely still noticeable.  For example, with
> informal iperf testing over a 10Gbps link, with full offload in a PF on
> one side and a VF in a VM on the other side on a CPU with AES instructions:
>
>     Reference:
>         No IPsec:                         9.4 Gbps
>         IPsec offload btwn two PFs:       9.2 Gbps
>     VF as the iperf receiver:
>         IPsec offload on PF, none on VF:  6.8 Gbps
>         IPsec offload on PF and VF:       9.2 Gbps   << biggest benefit
>     VF as the iperf sender:
>         IPsec offload on PF, none on VF:  4.8 Gbps
>         IPsec offload on PF and VF:       4.8 Gbps
>
> The iperf traffic is primarily uni-directional, and we can see the most
> benefit when VF is the iperf server and is receiving the test traffic.
> Watching output from sar also shows a nice decrease in CPU utilization.
>

So the one question I would have about this patch set is what happens
if you are setting up a ipsec connection between the PF and one of the
VFs on the same port/function? Do the ipsec offloads get translated
across the Tx loopback or do they end up causing issues? Specifically
I would be interested in seeing the results of a test either between
two VFs, or the PF and one of the VFs on the same port.

- Alex
