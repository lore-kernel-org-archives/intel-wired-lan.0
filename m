From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Aug 2018 14:15:12 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 0/8] ixgbe/ixgbevf: IPsec
 offload support for VFs
In-Reply-To: <5ff4527d-7557-10f4-f41e-3e618f0e5863@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdcijJ4f4gKeHj6t_EGuKjE7P5oZ0UH0_jfuHQ05RJALA@mail.gmail.com>
 <5ff4527d-7557-10f4-f41e-3e618f0e5863@oracle.com>
Message-ID: <CAKgT0UfjB35yWMALtLUh-dU78VUW95=8MMn8rLcnKiTQxOB-Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 14, 2018 at 10:10 AM Shannon Nelson
<shannon.nelson@oracle.com> wrote:
>
> On 8/14/2018 8:30 AM, Alexander Duyck wrote:
> > On Mon, Aug 13, 2018 at 11:43 AM Shannon Nelson
> > <shannon.nelson@oracle.com> wrote:
> >>
> >> This set of patches implements IPsec hardware offload for VF devices in
> >> Intel's 10Gbe x540 family of Ethernet devices.
>
> [...]
>
> >
> > So the one question I would have about this patch set is what happens
> > if you are setting up a ipsec connection between the PF and one of the
> > VFs on the same port/function? Do the ipsec offloads get translated
> > across the Tx loopback or do they end up causing issues? Specifically
> > I would be interested in seeing the results of a test either between
> > two VFs, or the PF and one of the VFs on the same port.
> >
> > - Alex
> >
>
> There is definitely something funky in the internal switch connection,
> as messages going from PF to VF with an offloaded encryption don't seem
> to get received by the VF, at least when in a VEB setup.  If I only set
> up offloads on the Rx on both PF and VF, and don't offload the Tx, then
> things work.
>
> I don't have a setup to test this, but I suspect that in a VEPA
> configuration, with packets going out to the switch and turned around
> back in, the Tx encryption offload would happen as expected.
>
> sln

We should probably look at adding at least one patch to the set then
that disables IPsec Tx offload if SR-IOV is enabled with VEB so that
we don't end up breaking connections should a VF be migrated from a
remote system to a local one that it is connected to.

- Alex
