From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 16 Dec 2020 12:20:53 +0100
Subject: [Intel-wired-lan] [PATCH 1/3] PCI/ASPM: Use the path max in L1
 ASPM latency check
In-Reply-To: <20201216000802.GA342490@bjorn-Precision-5520>
References: <CAA85sZvUvUTtyKR8rTDwGa=1sNrhv4cA8LQ+6TXi20Sq9Yn8fw@mail.gmail.com>
 <20201216000802.GA342490@bjorn-Precision-5520>
Message-ID: <CAA85sZsiuE9rN7uVCuhgiki-rffo4mYbh6BKvuGaJAK5CsPgKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 16, 2020 at 1:08 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 15, 2020 at 02:09:12PM +0100, Ian Kumlien wrote:
> > On Tue, Dec 15, 2020 at 1:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, Dec 14, 2020 at 11:56:31PM +0100, Ian Kumlien wrote:
> > > > On Mon, Dec 14, 2020 at 8:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > > > If you're interested, you could probably unload the Realtek drivers,
> > > > > remove the devices, and set the PCI_EXP_LNKCTL_LD (Link Disable) bit
> > > > > in 02:04.0, e.g.,
> > > > >
> > > > >   # RT=/sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/0000:02:04.0
> > > > >   # echo 1 > $RT/0000:04:00.0/remove
> > > > >   # echo 1 > $RT/0000:04:00.1/remove
> > > > >   # echo 1 > $RT/0000:04:00.2/remove
> > > > >   # echo 1 > $RT/0000:04:00.4/remove
> > > > >   # echo 1 > $RT/0000:04:00.7/remove
> > > > >   # setpci -s02:04.0 CAP_EXP+0x10.w=0x0010
> > > > >
> > > > > That should take 04:00.x out of the picture.
> > > >
> > > > Didn't actually change the behaviour, I'm suspecting an errata for AMD pcie...
> > > >
> > > > So did this, with unpatched kernel:
> > > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > > [  5]   0.00-1.00   sec  4.56 MBytes  38.2 Mbits/sec    0   67.9 KBytes
> > > > [  5]   1.00-2.00   sec  4.47 MBytes  37.5 Mbits/sec    0   96.2 KBytes
> > > > [  5]   2.00-3.00   sec  4.85 MBytes  40.7 Mbits/sec    0   50.9 KBytes
> > > > [  5]   3.00-4.00   sec  4.23 MBytes  35.4 Mbits/sec    0   70.7 KBytes
> > > > [  5]   4.00-5.00   sec  4.23 MBytes  35.4 Mbits/sec    0   48.1 KBytes
> > > > [  5]   5.00-6.00   sec  4.23 MBytes  35.4 Mbits/sec    0   45.2 KBytes
> > > > [  5]   6.00-7.00   sec  4.23 MBytes  35.4 Mbits/sec    0   36.8 KBytes
> > > > [  5]   7.00-8.00   sec  3.98 MBytes  33.4 Mbits/sec    0   36.8 KBytes
> > > > [  5]   8.00-9.00   sec  4.23 MBytes  35.4 Mbits/sec    0   36.8 KBytes
> > > > [  5]   9.00-10.00  sec  4.23 MBytes  35.4 Mbits/sec    0   48.1 KBytes
> > > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > > [ ID] Interval           Transfer     Bitrate         Retr
> > > > [  5]   0.00-10.00  sec  43.2 MBytes  36.2 Mbits/sec    0             sender
> > > > [  5]   0.00-10.00  sec  42.7 MBytes  35.8 Mbits/sec                  receiver
> > > >
> > > > and:
> > > > echo 0 > /sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/link/l1_aspm
> > >
> > > BTW, thanks a lot for testing out the "l1_aspm" sysfs file.  I'm very
> > > pleased that it seems to be working as intended.
> >
> > It was nice to find it for easy disabling :)
> >
> > > > and:
> > > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > > [  5]   0.00-1.00   sec   113 MBytes   951 Mbits/sec  153    772 KBytes
> > > > [  5]   1.00-2.00   sec   109 MBytes   912 Mbits/sec  276    550 KBytes
> > > > [  5]   2.00-3.00   sec   111 MBytes   933 Mbits/sec  123    625 KBytes
> > > > [  5]   3.00-4.00   sec   111 MBytes   933 Mbits/sec   31    687 KBytes
> > > > [  5]   4.00-5.00   sec   110 MBytes   923 Mbits/sec    0    679 KBytes
> > > > [  5]   5.00-6.00   sec   110 MBytes   923 Mbits/sec  136    577 KBytes
> > > > [  5]   6.00-7.00   sec   110 MBytes   923 Mbits/sec  214    645 KBytes
> > > > [  5]   7.00-8.00   sec   110 MBytes   923 Mbits/sec   32    628 KBytes
> > > > [  5]   8.00-9.00   sec   110 MBytes   923 Mbits/sec   81    537 KBytes
> > > > [  5]   9.00-10.00  sec   110 MBytes   923 Mbits/sec   10    577 KBytes
> > > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > > [ ID] Interval           Transfer     Bitrate         Retr
> > > > [  5]   0.00-10.00  sec  1.08 GBytes   927 Mbits/sec  1056             sender
> > > > [  5]   0.00-10.00  sec  1.07 GBytes   923 Mbits/sec                  receiver
> > > >
> > > > But this only confirms that the fix i experience is a side effect.
> > > >
> > > > The original code is still wrong :)
> > >
> > > What exactly is this machine?  Brand, model, config?  Maybe you could
> > > add this and a dmesg log to the buzilla?  It seems like other people
> > > should be seeing the same problem, so I'm hoping to grub around on the
> > > web to see if there are similar reports involving these devices.
> >
> > ASUS Pro WS X570-ACE with AMD Ryzen 9 3900X
>
> Possible similar issues:
>
>   https://forums.unraid.net/topic/94274-hardware-upgrade-woes/
>   https://forums.servethehome.com/index.php?threads/upgraded-my-home-server-from-intel-to-amd-virtual-disk-stuck-in-degraded-unhealty-state.25535/ (Windows)

Could be, I suspect that we need a workaround (is there a quirk for
"reporting wrong latency"?) and the patches.

> > > https://bugzilla.kernel.org/show_bug.cgi?id=209725
> > >
> > > Here's one that is superficially similar:
> > > https://linux-hardware.org/index.php?probe=e5f24075e5&log=lspci_all
> > > in that it has a RP -- switch -- I211 path.  Interestingly, the switch
> > > here advertises <64us L1 exit latency instead of the <32us latency
> > > your switch advertises.  Of course, I can't tell if it's exactly the
> > > same switch.
> >
> > Same chipset it seems
> >
> > I'm running bios version:
> >         Version: 2206
> >         Release Date: 08/13/2020
> >
> > ANd latest is:
> > Version 3003
> > 2020/12/07
> >
> > Will test upgrading that as well, but it could be that they report the
> > incorrect latency of the switch - I don't know how many things AGESA
> > changes but... It's been updated twice since my upgrade.
>
> I wouldn't be surprised if the advertised exit latencies are writable
> by the BIOS because it probably depends on electrical characteristics
> outside the switch.  If so, it's possible ASUS just screwed it up.

Not surprisingly, nothing changed.
(There was a lot of "stability improvements")
