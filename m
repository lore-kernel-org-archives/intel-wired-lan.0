From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sat, 25 Jul 2020 15:53:00 +0200
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZu0B2DybQuQD2uJO6r7HXkGFbAxV8VoG4qxE681yMwmfg@mail.gmail.com>
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
 <CAKgT0UfcPfNJCP=nT59t4RRwL3T8cQ5dnXeEgW1QXBG24fo-Cg@mail.gmail.com>
 <CAA85sZsEG_SCC4GLb8xaUsESrzZyAwF0qmse6sJ=e1QkK9DVsQ@mail.gmail.com>
 <CAKgT0UcY4FwAFf0BXv7vc_5ram7YkFXda78PWkdEFgMLsitvWA@mail.gmail.com>
 <CAA85sZs_PSsyZhvdKBCoAGxoZvaQFhQ6j7qoA7y8ffjs2RqEGw@mail.gmail.com>
 <CAKgT0UeL4kcV4eO-3f-xTMzO5Lc+jNjeOya3=nA21wyrkv37FA@mail.gmail.com>
 <CAA85sZv=u2EaLKuTvrOnKRn1AKkdpYcG4038zZde_3cMLMAfNw@mail.gmail.com>
 <CAA85sZvTrmKhmoW6xASgOcZqPhLMkgy_LyfzvkGcqURUuvVxcg@mail.gmail.com>
 <CAA85sZvtct5qzNMAcO=jjcfuFPJ4dVfyUDzyXdqAmNDdoLUXuA@mail.gmail.com>
 <CAKgT0UdanNRN_KFkUjjpkiMPfi1ktjeD1ejiqnU_rU-0wJVn5A@mail.gmail.com>
 <CAA85sZu0B2DybQuQD2uJO6r7HXkGFbAxV8VoG4qxE681yMwmfg@mail.gmail.com>
Message-ID: <CAA85sZtm8W8NHhQ-vg1HQzAyUE6hdjkO4c5M7BEbgZwC_DUsSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jul 25, 2020 at 3:03 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> On Sat, Jul 25, 2020 at 2:45 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Fri, Jul 24, 2020 at 4:08 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:

[--8<--]

> > Actually I think it is max(a.dw, b.up) + max(b.dw, a.up). Basically
> > what you want is the maximum time to bring the link up so technically
> > you only have 2 links so you just have to add up the maximum time to
> > create each link.
>
> Ah so it's not cumulative per link, only max value on one, got it!
>
> > > Also, we only disabled L0, which isn't counted as a total at all, it
> > > only checks each side.
> >
> > Not sure what you mean here. L0 is the link fully powered on. The two
> > link states we have to worry about are L0s and L1 as those involve
> > various states of power-down. The L1 latency is the nasty one as that
> > basically involves fully powering down the link and requires time for
> > the link to be reestablished.
>
> we basically did the &= ~ASPM_STATE_L0S - is the S indicative of something?
>
> > > Since pcie is serial and judging from your previous statements I
> > > assume that the max statement is a bug.
> > > I also assume that l0 counts, and should be dealt with the same way
> > > and it should also be cumulative...
> >
> > That latency check looks like it would be for a single link. Not each
> > link in the chain.
>
> Yes, it checks each link in the chain, which is incorrect, it's actually the
> cumulative latency that is important... Well... according to what I have
> been able to gather from various documents anyway ;)
>
> > > The question becomes, is this latency from root? or is it "one step"?
> >
> > Actually the function is doing both. I had to reread the spec.
> > Basically the switch is supposed to start trying to bring up the other
> > links as soon as it detects that we are trying to bring up the link.
> > In theory this is only supposed to add about 1us. So in theory the
> > total bring-up time should be 33us.
>
> Ah ok, thanks, that answers another question in the chain ;)

So, then this is what should be done:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..2b8f7ea7f7bc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency = 0;
+       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev
*endpoint)
                 * substate latencies (and hence do not do any check).
                 */
                latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
+               l1_max_latency = max_t(u32, latency, l1_max_latency)
                if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
+                   (l1_max_latency + l1_switch_latency > acceptable->l1))
                        link->aspm_capable &= ~ASPM_STATE_L1;
                l1_switch_latency += 1000;
---

for l1 latency... I do however find it odd that you don't disable it
on the endpoint but on the
potential bridge/switch/root you're on - shouldn't the disable be on
endpoint->bus->self->link_state?

Anyway, this should handle any latency bumps... and could be done
differently reusing latency and:
latency = max_t(u32, latency, max_t(u32, link->latency_up.l1,
link->latency_dw.l1));

but kept it this way for legibility...

But for L0 -- been looking at it and I wonder... from what I can see
it's cumulative for the link, but L0S seems
different and is perhaps not quite the same...

[--8<--]

> > Something still isn't adding up with all this as the latency shouldn't
> > be enough to trigger buffer overruns. I wonder if we don't have
> > something that is misreporting the actual L1 wakeup latency. One thing
> > that I notice is that the link between the root complex and the PCIe
> > switch seems to have some sort of electrical issue. If you look at the
> > section from the upstream side of the switch:
> > LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <32us
> > ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> > LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
> > ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > LnkSta: Speed 16GT/s (ok), Width x4 (downgraded)
> > TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >
> > One thing that catches my eye is that it is only linked at x4 when
> > both sides are listing themselves as x8. Do you know if this has ever
> > linked at x8 or has it always been x4? With this being a Gen 4 x8
> > connection it would normally take a little while to establish a link,
> > but with it having to fail down to a x4 that would add extra time and
> > likely push it out of the expected exit latency. Also I notice that
> > there are mentions of lane errors in the config, however I suspect
> > those are Gen 4 features that I am not familiar with so I don't know
> > if those are normal. It might be interesting to reboot and see if the
> > link goes back to a x8 and if the lane errors clear at some point. If
> > it does then we might want to disable ASPM on the upstream port of the
> > switch since I have seen ASPM cause link downgrades and that may be
> > what is occurring here.
>
> Humm... And that would mean disabling ASPM completely to test?
