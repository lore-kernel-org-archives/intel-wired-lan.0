From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sat, 25 Jul 2020 21:35:44 +0200
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZsk0N_G=w+qFxuOwD=C+BQxy1Nh1ZD4ud+gwzO_gu5H6Q@mail.gmail.com>
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
 <CAA85sZtm8W8NHhQ-vg1HQzAyUE6hdjkO4c5M7BEbgZwC_DUsSw@mail.gmail.com>
 <CAKgT0Ue0JEmn2zN7yenohow8KhsX6jVfG4X0+Gt+p0uJijoTzA@mail.gmail.com>
 <CAA85sZsk0N_G=w+qFxuOwD=C+BQxy1Nh1ZD4ud+gwzO_gu5H6Q@mail.gmail.com>
Message-ID: <CAA85sZtif5bGEYQjA2mb4-8n5N9FB9oL-y0LuZ6P4hhR=7=d2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jul 25, 2020 at 8:56 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Sat, Jul 25, 2020 at 7:43 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > On Sat, Jul 25, 2020 at 6:53 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > On Sat, Jul 25, 2020 at 3:03 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > On Sat, Jul 25, 2020 at 2:45 AM Alexander Duyck
> > > > <alexander.duyck@gmail.com> wrote:
> > > > > On Fri, Jul 24, 2020 at 4:08 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > [--8<--]
> > >
> > > > > Actually I think it is max(a.dw, b.up) + max(b.dw, a.up). Basically
> > > > > what you want is the maximum time to bring the link up so technically
> > > > > you only have 2 links so you just have to add up the maximum time to
> > > > > create each link.
> > > >
> > > > Ah so it's not cumulative per link, only max value on one, got it!
> > > >
> > > > > > Also, we only disabled L0, which isn't counted as a total at all, it
> > > > > > only checks each side.
> > > > >
> > > > > Not sure what you mean here. L0 is the link fully powered on. The two
> > > > > link states we have to worry about are L0s and L1 as those involve
> > > > > various states of power-down. The L1 latency is the nasty one as that
> > > > > basically involves fully powering down the link and requires time for
> > > > > the link to be reestablished.
> > > >
> > > > we basically did the &= ~ASPM_STATE_L0S - is the S indicative of something?
> > > >
> > > > > > Since pcie is serial and judging from your previous statements I
> > > > > > assume that the max statement is a bug.
> > > > > > I also assume that l0 counts, and should be dealt with the same way
> > > > > > and it should also be cumulative...
> > > > >
> > > > > That latency check looks like it would be for a single link. Not each
> > > > > link in the chain.
> > > >
> > > > Yes, it checks each link in the chain, which is incorrect, it's actually the
> > > > cumulative latency that is important... Well... according to what I have
> > > > been able to gather from various documents anyway ;)
> > > >
> > > > > > The question becomes, is this latency from root? or is it "one step"?
> > > > >
> > > > > Actually the function is doing both. I had to reread the spec.
> > > > > Basically the switch is supposed to start trying to bring up the other
> > > > > links as soon as it detects that we are trying to bring up the link.
> > > > > In theory this is only supposed to add about 1us. So in theory the
> > > > > total bring-up time should be 33us.
> > > >
> > > > Ah ok, thanks, that answers another question in the chain ;)
> > >
> > > So, then this is what should be done:
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index b17e5ffd31b1..2b8f7ea7f7bc 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> > >
> > >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > >  {
> > > -       u32 latency, l1_switch_latency = 0;
> > > +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
> > >         struct aspm_latency *acceptable;
> > >         struct pcie_link_state *link;
> > >
> > > @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev
> > > *endpoint)
> > >                  * substate latencies (and hence do not do any check).
> > >                  */
> > >                 latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > > +               l1_max_latency = max_t(u32, latency, l1_max_latency)
> > >                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> > > -                   (latency + l1_switch_latency > acceptable->l1))
> > > +                   (l1_max_latency + l1_switch_latency > acceptable->l1))
> > >                         link->aspm_capable &= ~ASPM_STATE_L1;
> > >                 l1_switch_latency += 1000;
> > > ---
> >
> > This makes sense to me. You might want to submit it to the linux-pci
> > mailing list.
>
> Will after trying it and adding the missing ';'

So rebooted, and the chain we had was:
00:01.2->1:00.0 -> 2:03.0 -> 3:00.0

And with my patch, we have:
for x in 00:01.2 1:00.0 2:03.0 3:00.0 ; do echo $x && lspci -s $x -vvv
|grep LnkCtl ; done
00:01.2
LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
01:00.0
LnkCtl: ASPM Disabled; Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
2:03.0
LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
3:00.0
LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

And the siwtch is still downgraded so i suspect a lack of physical lines...
LnkSta: Speed 16GT/s (ok), Width x4 (downgraded)
TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-

Just disabling the endpoint however results in:
for x in 00:01.2 1:00.0 2:03.0 3:00.0 ; do echo $x && lspci -s $x -vvv
|grep LnkCtl ; done
00:01.2
LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
1:00.0
LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
2:03.0
LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
3:00.0
LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
----

Ie, it didn't seem to apply...

Looking at the differences:
diff -u lscpi-root.output lscpi-endpoint.output
--- lscpi-root.output 2020-07-25 21:24:10.661458522 +0200
+++ lscpi-endpoint.output 2020-07-25 21:20:50.316049129 +0200
@@ -3,7 +3,6 @@
 00:00.2
 00:01.0
 00:01.2
- LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 00:02.0
 00:03.0
 00:03.1
@@ -27,7 +26,6 @@
 00:18.6
 00:18.7
 01:00.0
- LnkCtl: ASPM Disabled; Disabled- CommClk+
 02:03.0
 02:04.0
  LnkCtl: ASPM Disabled; Disabled- CommClk+

So that handles two bridges then...
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Matisse Switch
Upstream (prog-if 00 [Normal decode])

And these two had ASPM Enabled before my changes... They actually seem
to fix it as well! ;)





> > > for l1 latency... I do however find it odd that you don't disable it
> > > on the endpoint but on the
> > > potential bridge/switch/root you're on - shouldn't the disable be on
> > > endpoint->bus->self->link_state?
> >
> > I think the idea is that we want to leave the leaves of the root
> > complex with ASPM enabled and disable it as we approach the trunk as
> > it is more likely that we are going to see more frequent wakeups as we
> > approach the root complex, or at least that would be my theory anyway.
> > Basically the closer you get to the root complex the more likely you
> > are to have more devices making use of the path so the more likely it
> > is to have to stay on anyway.
>
> Well since we walk from endpoint to root complex, it's actually more
> likely that we disable the root complex...
>
> since max_latency + hops will be the largest number there
>
> > > Anyway, this should handle any latency bumps... and could be done
> > > differently reusing latency and:
> > > latency = max_t(u32, latency, max_t(u32, link->latency_up.l1,
> > > link->latency_dw.l1));
> > >
> > > but kept it this way for legibility...
> > >
> > > But for L0 -- been looking at it and I wonder... from what I can see
> > > it's cumulative for the link, but L0S seems
> > > different and is perhaps not quite the same...
> >
> > You have mentioned L0 several times now and I wonder what you are
> > referring to. L0 is the fully powered on state. That is the state we
> > are trying to get back to. L0s and L1 are the lower power states that
> > we have to get out of with L1 being a much more complicated state to
> > get out of as we shut down the clocks and link if I recall and have to
> > reestablish both before we can resume operation.
>
> Yeah, trying to understand it all...
>
> Reading about L0 says that the latency covers the whole chain, but i
> don't know if there is a
> case for L0s that I'm missing since it seems hard to get informastion
> about it and how it works
>
> Basically, is the L0s check correct? or should it be changed? Should
> it respect the limitations set forth for L0?
> or is it completely different?
>
> I'm really thankful for all the information you've been providing :)
