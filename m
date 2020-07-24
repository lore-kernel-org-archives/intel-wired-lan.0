From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Jul 2020 07:56:59 -0700
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZvMjcRnuECtFBDKKAG3q2MGeytsxPx8RR-M4hSxruj5Vw@mail.gmail.com>
References: <CAA85sZvKNXCo5bB5a6kKmsOUAiw+_daAVaSYqNW6QbSBJ0TcyQ@mail.gmail.com>
 <CAA85sZua6Q8UR7TfCGO0bV=VU0gKtqj-8o_mqH38RpKrwYZGtg@mail.gmail.com>
 <20200715133136.5f63360c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAA85sZu09Z4gydJ8rAO_Ey0zqx-8Lg28=fBJ=FxFnp6cetNd3g@mail.gmail.com>
 <CAA85sZtjCW2Yg+tXPgYyoFA5BKAVZC8kVKG=6SiR64c8ur8UcQ@mail.gmail.com>
 <20200715144017.47d06941@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAA85sZvnytPzpia_ROnkmJoZC8n4vUsrwTQh2UBs6u6g2Fgqxw@mail.gmail.com>
 <CAKgT0UdwsmE=ygE2KObzM0z-0KgrPcr59JZzVk41F6-iqsSL+Q@mail.gmail.com>
 <CAA85sZturDN7uOHMDhUnntM43PHjop=TNDb4qvEA2L=jdRa1MA@mail.gmail.com>
 <CAKgT0Uf42EhnM+zPSb-oL1R8hmo0vEdssGztptbkWKoHXS7ygw@mail.gmail.com>
 <CAA85sZtHNkocj840i0ohMVekh0B4byuojU02UunK_bR+LB1WiQ@mail.gmail.com>
 <CAKgT0UdDjabvShwDv0qiume=Q2RKGkm3JhPMZ+f8v5yO37ZLxA@mail.gmail.com>
 <CAA85sZt6B+rG8pUfRoNVOH=VqHn=rT-+2kHpFDzW+eBwvODxJA@mail.gmail.com>
 <CAKgT0UfhMjZ6kZSkfpEVHBbQ+4eHQqWRbXk5Sm4nLQD6sSrj0A@mail.gmail.com>
 <CAA85sZs5D_ReOhsEv1SVbE5D8q77utNBZ=Uv34PVof9gHs9QWw@mail.gmail.com>
 <CAA85sZvi4x1zc_21a6zPJw0rELOY=RCV4W7Fi4fvcSXfy-6m4g@mail.gmail.com>
 <CAA85sZvMjcRnuECtFBDKKAG3q2MGeytsxPx8RR-M4hSxruj5Vw@mail.gmail.com>
Message-ID: <CAKgT0UfcPfNJCP=nT59t4RRwL3T8cQ5dnXeEgW1QXBG24fo-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jul 24, 2020 at 5:33 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 2:01 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > On Fri, Jul 17, 2020 at 3:45 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> [--8<--]
>
> > As a side note, would something like this fix it - not even compile tested
> >
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 8bb3db2cbd41..1a7240aae85c 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -3396,6 +3396,13 @@ static int igb_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >                           "Width x2" :
> >                           (hw->bus.width == e1000_bus_width_pcie_x1) ?
> >                           "Width x1" : "unknown"), netdev->dev_addr);
> > +               /* quirk */
> > +#ifdef CONFIG_PCIEASPM
> > +               if (hw->bus.width == e1000_bus_width_pcie_x1) {
> > +                       /* single lane pcie causes problems with ASPM */
> > +                       pdev->pcie_link_state->aspm_enabled = 0;
> > +               }
> > +#endif
> >         }
> >
> >         if ((hw->mac.type >= e1000_i210 ||
> >
> > I don't know where the right place to put a quirk would be...
>
> Ok so that was a real brainfart... turns out that there is a lack of
> good ways to get to that but it was more intended to
> know where the quirk should go...
>
> Due to the lack of api:s i started wondering if this will apply to
> more devices than just network cards - potentially we could
> be a little bit more selective and only not enable it in one direction but...
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..96a3c6837124 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -584,15 +584,16 @@ static void pcie_aspm_cap_init(struct
> pcie_link_state *link, int blacklist)
>          * given link unless components on both sides of the link each
>          * support L0s.
>          */
> -       if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
> -               link->aspm_support |= ASPM_STATE_L0S;
> -       if (dwreg.enabled & PCIE_LINK_STATE_L0S)
> -               link->aspm_enabled |= ASPM_STATE_L0S_UP;
> -       if (upreg.enabled & PCIE_LINK_STATE_L0S)
> -               link->aspm_enabled |= ASPM_STATE_L0S_DW;
> -       link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
> -       link->latency_dw.l0s = calc_l0s_latency(dwreg.latency_encoding_l0s);
> -
> +       if (pcie_get_width_cap(child) != PCIE_LNK_X1) {
> +               if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
> +                       link->aspm_support |= ASPM_STATE_L0S;
> +               if (dwreg.enabled & PCIE_LINK_STATE_L0S)
> +                       link->aspm_enabled |= ASPM_STATE_L0S_UP;
> +               if (upreg.enabled & PCIE_LINK_STATE_L0S)
> +                       link->aspm_enabled |= ASPM_STATE_L0S_DW;
> +               link->latency_up.l0s =
> calc_l0s_latency(upreg.latency_encoding_l0s);
> +               link->latency_dw.l0s =
> calc_l0s_latency(dwreg.latency_encoding_l0s);
> +       }
>
> this time it's compile tested...
>
> It could also be  if (pcie_get_width_cap(child) > PCIE_LNK_X1) {
>
> I assume that ASPM is not enabled for: PCIE_LNK_WIDTH_RESRV ;)

This is probably a bit too broad of a scope to be used generically
since this will disable ASPM for all devices that have a x1 link
width.

It might make more sense to look at something such as
e1000e_disable_aspm as an example of how to approach this.

As far as what triggers it we would need to get more details about the
setup. I'd be curious if we have an "lspci -vvv" for the system
available. The assumption is that the ASPM exit latency is high on
this system and that in turn is causing the bandwidth issues as you
start entering L1. If I am not mistaken the device should advertise
about 16us for the exit latency. I'd be curious if we have a device
somewhere between the NIC and the root port that might be increasing
the delay in exiting L1, and then if we could identify that we could
add a PCIe quirk for that.

Thanks.

- Alex
