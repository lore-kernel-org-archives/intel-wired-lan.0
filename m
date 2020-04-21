From: Ralf Ertzinger <ralf@camperquake.de>
Date: Tue, 21 Apr 2020 13:37:45 +0000
Subject: [Intel-wired-lan] i350 not coming out of D3 when link should be
 reestablished
Message-ID: <20200421133745.GA1557688@shell-202.tara.dn.lalufu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have a Supermicro board (M11SDV-4C-LN4F) which has one (or four? not
sure) i350 network cards, breaking out into four 1GB RJ45 ports:

03:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
03:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
03:00.2 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
03:00.3 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)

I'm running fedora kernels, currently 5.5.17-200.fc31.x86_64.

The cards are driven by the igb driver.

When enabling PCIe powersaving by setting ATTR{power/control}="auto"
through udev, I observe the following:

- Interfaces that have no link when the driver is loaded are unable to
  establish link when a cable is inserted. The lights flicker, but no
  link establishment takes place

- Interfaces that have no link when the driver is loaded show up in "ip
  link show", but cannot be configured:

  # ip addr del 192.168.1.1/24 dev eno1
  RTNETLINK answers: Cannot assign requested address

- Interfaces that have no link when the driver is loaded cannot be
  inspected with ethtool:

  # ethtool -t eno1
  Cannot get strings: No such device

- Interfaces that have link when the driver is loaded work, but cannot
  regain link when it's lost.

- Reading the temperature sensor via /sys/class/hwmon results in a
  reading of 255 degrees:

  # cat /sys/class/hwmon/hwmon0/name 
  i350bb
  # cat /sys/class/hwmon/hwmon0/temp1_input 
  255000

If I leave ATTR{power/control}="on", everything works fine.

Is this expected behaviour?

If any further information/logs/output is required please just ask.
