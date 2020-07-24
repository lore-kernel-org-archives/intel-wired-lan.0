From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 24 Jul 2020 14:01:07 +0200
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZs5D_ReOhsEv1SVbE5D8q77utNBZ=Uv34PVof9gHs9QWw@mail.gmail.com>
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
Message-ID: <CAA85sZvi4x1zc_21a6zPJw0rELOY=RCV4W7Fi4fvcSXfy-6m4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jul 17, 2020 at 3:45 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Fri, Jul 17, 2020 at 2:09 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Thu, Jul 16, 2020 at 12:47 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> > > Sorry, tried to respond via the phone, used the webbrowser version but
> > > still html mails... :/
>
> > > On Thu, Jul 16, 2020 at 5:18 PM Alexander Duyck
> > > <alexander.duyck@gmail.com> wrote:
> > > > On Wed, Jul 15, 2020 at 5:00 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> [--8<--]
>
> > > > > Well... I'll be damned... I used to force enable ASPM... this must be
> > > > > related to the change in PCIe bus ASPM
> > > > > Perhaps disable ASPM if there is only one link?
> > > >
> > > > Is there any specific reason why you are enabling ASPM? Is this system
> > > > a laptop where you are trying to conserve power when on battery? If
> > > > not disabling it probably won't hurt things too much since the power
> > > > consumption for a 2.5GT/s link operating in a width of one shouldn't
> > > > bee too high. Otherwise you are likely going to end up paying the
> > > > price for getting the interface out of L1 when the traffic goes idle
> > > > so you are going to see flows that get bursty paying a heavy penalty
> > > > when they start dropping packets.
> > >
> > > Ah, you misunderstand, I used to do this and everything worked - now
> > > Linux enables ASPM by default on all pcie controllers,
> > > so imho this should be a quirk, if there is only one lane, don't do
> > > ASPM due to latency and timing issues...
> > >
> > > > It is also possible this could be something that changed with the
> > > > physical PCIe link. Basically L1 works by powering down the link when
> > > > idle, and then powering it back up when there is activity. The problem
> > > > is bringing it back up can sometimes be a challenge when the physical
> > > > link starts to go faulty. I know I have seen that in some cases it can
> > > > even result in the device falling off of the PCIe bus if the link
> > > > training fails.
> > >
> > > It works fine without ASPM (and the machine is pretty new)
> > >
> > > I suspect we hit some timing race with aggressive ASPM (assumed as
> > > such since it works on local links but doesn't on ~3 ms Links)
> >
> > Agreed. What is probably happening if you are using a NAT is that it
> > may be seeing some burstiness being introduced and as a result the
> > part is going to sleep and then being overrun when the traffic does
> > arrive.
>
> Weird though, seems to be very aggressive timings =)
>
> [--8<--]
>
> > > > > ethtool -S enp3s0 |grep -v ": 0"
> > > > > NIC statistics:
> > > > >      rx_packets: 16303520
> > > > >      tx_packets: 21602840
> > > > >      rx_bytes: 15711958157
> > > > >      tx_bytes: 25599009212
> > > > >      rx_broadcast: 122212
> > > > >      tx_broadcast: 530
> > > > >      rx_multicast: 333489
> > > > >      tx_multicast: 18446
> > > > >      multicast: 333489
> > > > >      rx_missed_errors: 270143
> > > > >      rx_long_length_errors: 6
> > > > >      tx_tcp_seg_good: 1342561
> > > > >      rx_long_byte_count: 15711958157
> > > > >      rx_errors: 6
> > > > >      rx_length_errors: 6
> > > > >      rx_fifo_errors: 270143
> > > > >      tx_queue_0_packets: 8963830
> > > > >      tx_queue_0_bytes: 9803196683
> > > > >      tx_queue_0_restart: 4920
> > > > >      tx_queue_1_packets: 12639010
> > > > >      tx_queue_1_bytes: 15706576814
> > > > >      tx_queue_1_restart: 12718
> > > > >      rx_queue_0_packets: 16303520
> > > > >      rx_queue_0_bytes: 15646744077
> > > > >      rx_queue_0_csum_err: 76
> > > >
> > > > Okay, so this result still has the same length and checksum errors,
> > > > were you resetting the system/statistics between runs?
> > >
> > > Ah, no.... Will reset and do more tests when I'm back home
> > >
> > > Am I blind or is this part missing from ethtools man page?
> >
> > There isn't a reset that will reset the stats via ethtool. The device
> > stats will be persistent until the driver is unloaded and reloaded or
> > the system is reset. You can reset the queue stats by changing the
> > number of queues. So for example using "ethtool -L enp3s0 1;  ethtool
> > -L enp3s0 2".

As a side note, would something like this fix it - not even compile tested


diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
b/drivers/net/ethernet/intel/igb/igb_main.c
index 8bb3db2cbd41..1a7240aae85c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3396,6 +3396,13 @@ static int igb_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)
                          "Width x2" :
                          (hw->bus.width == e1000_bus_width_pcie_x1) ?
                          "Width x1" : "unknown"), netdev->dev_addr);
+               /* quirk */
+#ifdef CONFIG_PCIEASPM
+               if (hw->bus.width == e1000_bus_width_pcie_x1) {
+                       /* single lane pcie causes problems with ASPM */
+                       pdev->pcie_link_state->aspm_enabled = 0;
+               }
+#endif
        }

        if ((hw->mac.type >= e1000_i210 ||

I don't know where the right place to put a quirk would be...
